@echo off
setlocal

:: Configuration
set PORT=5173
set URL=http://localhost:%PORT%
set SIGNAL=%TEMP%\linda-splash-ready.signal
set PROJECT_DIR=C:\Users\ofirm\.linda-local
set TIMEOUT_SECONDS=60
set SCRIPT_DIR=%~dp0

:: Clean stale signal file
del "%SIGNAL%" 2>nul

:: Launch splash screen (PowerShell runs hidden but the WPF window shows)
start "" powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%SCRIPT_DIR%splash.ps1" -Port %PORT% -SignalFile "%SIGNAL%" -TimeoutSeconds %TIMEOUT_SECONDS%

:: Start dev server completely hidden
start "" /B powershell.exe -NoProfile -WindowStyle Hidden -Command "Set-Location '%PROJECT_DIR%'; npm run dev 2>&1 | Out-Null"

:: Poll until the dev server responds
set /a ELAPSED=0
:poll
if %ELAPSED% GEQ %TIMEOUT_SECONDS% goto timeout
timeout /t 1 /nobreak >nul
set /a ELAPSED+=1
powershell -NoProfile -Command "try { $r = Invoke-WebRequest -Uri '%URL%' -UseBasicParsing -TimeoutSec 2; if($r.StatusCode -eq 200){exit 0} } catch {}; exit 1"
if errorlevel 1 goto poll

:: Server is ready — signal splash to close
echo ready > "%SIGNAL%"

:: Wait for splash fade-out animation
timeout /t 1 /nobreak >nul

:: Open browser
start "" "%URL%"

goto end

:timeout
:: Signal splash to close (it also has its own timeout)
echo ready > "%SIGNAL%"
echo ERROR: Server did not start within %TIMEOUT_SECONDS% seconds.
pause

:end
endlocal
exit /b 0
