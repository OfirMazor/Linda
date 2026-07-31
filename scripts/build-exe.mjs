/**
 * Builds Linda into a portable distribution:
 * 1. Builds the Vite client into dist/client/
 * 2. Bundles the Express server with esbuild into dist/server.cjs
 * 3. Copies node.exe from the current system for portable execution
 * 4. Creates a launcher batch file
 *
 * Result: dist/ folder can run on any Windows x64 PC without Node.js installed.
 */
import { execSync } from "child_process";
import { cpSync, mkdirSync, rmSync, existsSync, writeFileSync, statSync } from "fs";
import path from "path";

const ROOT = path.resolve(import.meta.dirname, "..");
const DIST = path.join(ROOT, "dist");

function run(cmd, cwd = ROOT) {
  console.log(`> ${cmd}`);
  execSync(cmd, { cwd, stdio: "inherit" });
}

// Clean dist
if (existsSync(DIST)) {
  rmSync(DIST, { recursive: true });
}
mkdirSync(DIST, { recursive: true });

// Step 1: Build client
console.log("\n=== Building client ===");
run("npx vite build --outDir ../dist/client", path.join(ROOT, "client"));

// Step 2: Bundle server with esbuild (ESM → CJS single file)
console.log("\n=== Bundling server ===");

// Create empty stubs for Azure packages (not needed — we use SQL auth, not Azure AD)
const stubDir = path.join(ROOT, "scripts", "_stubs");
mkdirSync(stubDir, { recursive: true });
writeFileSync(path.join(stubDir, "empty.js"), "module.exports = {};");

run(
  [
    "npx esbuild server/src/index.ts",
    "--bundle",
    "--platform=node",
    "--target=node20",
    "--format=cjs",
    "--outfile=dist/server.cjs",
    "--alias:@azure/identity=./scripts/_stubs/empty.js",
    "--alias:@azure/keyvault-keys=./scripts/_stubs/empty.js",
    '--banner:js="const import_meta_url = require(\'url\').pathToFileURL(__filename).href;"',
    "--define:import.meta.url=import_meta_url",
    '--define:process.env.NODE_ENV=\\"production\\"',
  ].join(" ")
);

// Step 3: Copy node.exe from this system
console.log("\n=== Copying Node.js runtime ===");
const nodeExe = process.execPath;
cpSync(nodeExe, path.join(DIST, "node.exe"));
console.log(`Copied ${nodeExe} (${Math.round(statSync(nodeExe).size / 1024 / 1024)}MB)`);

// Step 4: Create launcher and support files
mkdirSync(path.join(DIST, "data"), { recursive: true });

// Include ownership cache so machines without internet access have data
const cacheSource = path.join(ROOT, "server", "data", "tabu-cache.json");
if (existsSync(cacheSource)) {
  cpSync(cacheSource, path.join(DIST, "data", "tabu-cache.json"));
  console.log("Included tabu-cache.json in dist/data/");
} else {
  console.warn("WARNING: server/data/tabu-cache.json not found — dist will have no ownership fallback");
}

cpSync(path.join(ROOT, ".env.example"), path.join(DIST, ".env.example"));

// Copy splash screen assets
console.log("\n=== Copying splash screen assets ===");
mkdirSync(path.join(DIST, "fonts"), { recursive: true });
cpSync(path.join(ROOT, "fonts", "Sekuya-Regular.ttf"), path.join(DIST, "fonts", "Sekuya-Regular.ttf"));
cpSync(path.join(ROOT, "splash.ps1"), path.join(DIST, "splash.ps1"));
console.log("Copied splash.ps1 and fonts/Sekuya-Regular.ttf");

writeFileSync(
  path.join(DIST, "linda.bat"),
  [
    "@echo off",
    "title Linda — Land Indicator",
    'cd /d "%~dp0"',
    'start "" cmd /c "timeout /t 3 /noexec >nul & start http://localhost:3001"',
    "node.exe server.cjs",
    "pause",
    "",
  ].join("\r\n")
);

writeFileSync(
  path.join(DIST, "linda-app.bat"),
  [
    "@echo off",
    "setlocal",
    "",
    ":: Configuration",
    "set PORT=3001",
    "set URL=http://localhost:%PORT%",
    "set HEALTH_URL=http://localhost:%PORT%/api/health",
    "set SIGNAL=%TEMP%\\linda-splash-ready.signal",
    "set TIMEOUT_SECONDS=60",
    'set SCRIPT_DIR=%~dp0',
    "",
    ":: Clean stale signal file",
    'del "%SIGNAL%" 2>nul',
    "",
    ":: Launch splash screen",
    'start "" powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%SCRIPT_DIR%splash.ps1" -Port %PORT% -SignalFile "%SIGNAL%" -TimeoutSeconds %TIMEOUT_SECONDS%',
    "",
    ":: Start production server completely hidden",
    'start "" /B powershell.exe -NoProfile -WindowStyle Hidden -Command "Set-Location \'%~dp0\'; .\\node.exe server.cjs 2>&1 | Out-Null"',
    "",
    ":: Poll until the server responds",
    "set /a ELAPSED=0",
    ":poll",
    "if %ELAPSED% GEQ %TIMEOUT_SECONDS% goto timeout",
    "timeout /t 1 /nobreak >nul",
    "set /a ELAPSED+=1",
    "powershell -NoProfile -Command \"try { $r = Invoke-WebRequest -Uri '%HEALTH_URL%' -UseBasicParsing -TimeoutSec 2; if($r.StatusCode -eq 200){exit 0} } catch {}; exit 1\"",
    "if errorlevel 1 goto poll",
    "",
    ":: Server is ready — signal splash to close",
    'echo ready > "%SIGNAL%"',
    "",
    ":: Wait for splash fade-out animation",
    "timeout /t 1 /nobreak >nul",
    "",
    ":: Open browser",
    'start "" "%URL%"',
    "",
    "goto end",
    "",
    ":timeout",
    'echo ready > "%SIGNAL%"',
    "echo ERROR: Server did not start within %TIMEOUT_SECONDS% seconds.",
    "pause",
    "",
    ":end",
    "endlocal",
    "exit /b 0",
    "",
  ].join("\r\n")
);

console.log("\n=== Done ===");
console.log("Output in dist/ folder:");
console.log("  linda-app.bat   — user-friendly launcher (splash screen)");
console.log("  linda.bat       — debug launcher (shows server logs)");
console.log("  node.exe        — portable Node.js runtime");
console.log("  server.cjs      — bundled server");
console.log("  client/         — static frontend");
console.log("  splash.ps1      — splash screen script");
console.log("  fonts/          — bundled fonts");
console.log("  .env.example    — copy to .env and fill in credentials");
console.log("  data/           — ownership cache (auto-populated)");
console.log("\nTo distribute: copy the entire dist/ folder to the target PC.");
console.log("Rename .env.example → .env and fill in DB credentials, then run linda-app.bat.");
