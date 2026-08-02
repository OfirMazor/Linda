# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Linda** (Land Indicators) is a single-page dashboard for Israel's National Cadaster. It visualizes cadastral data — land parcels, ownership, processes, and boundary accuracy — using interactive charts and spatial maps.

## Development Environment

- **Platform**: Windows 11
- **Project directory**: `C:\Users\ofirm\Desktop\Linda` — this is the sole location for all project files, `node_modules`, and dev servers.
- **No git repository**
- **No test framework or linter** is currently configured.

## Commands

```bash
# From the project directory (C:\Users\ofirm\Desktop\Linda):
npm install              # Install all workspace deps
npm run dev              # Start both client (5173) and server (3001)
npm run dev:client       # Vite dev server only (http://localhost:5173)
npm run dev:server       # Express server only (http://localhost:3001)
npm run build            # Build client + server for production

# Production start (after build):
npm start --workspace=server   # Runs node dist/index.js
```

**Quick launch**: `start-linda.bat` opens the browser and runs `npm run dev`.

```bash
# Build portable distribution (no Node.js install needed on target machine):
npm run build:exe        # Outputs dist/ folder (~90MB) with node.exe + bundled server + client
```

### Distribution (`dist/`)

`npm run build:exe` produces a self-contained folder. Copy the entire `dist/` to any Windows x64 PC — rename `.env.example` → `.env`, fill in DB credentials, double-click `linda.bat`. Contents: `node.exe` (portable runtime), `server.cjs` (bundled server), `client/` (static frontend), `data/` (runtime cache).

## Architecture

Monorepo with npm workspaces: `client/` and `server/`.

### Client (`client/`) — React + TypeScript + Vite

- **MapLibre GL JS** for vector map rendering (OSM raster basemap, centered on Israel at [34.85, 31.5])
- **Recharts** for donut/ring charts and histograms
- **@react-oauth/google** for Google SSO
- Vite proxies `/api/*` requests to Express backend (port 3001)
- Path alias: `@/` → `client/src/` (configured in `vite.config.ts` and `tsconfig.json`)
- Env var: `VITE_GOOGLE_CLIENT_ID` in `client/.env`
- Theme: light/dark via `data-theme` attribute on `<html>`, all colors from CSS custom properties in `client/src/styles/variables.css`
- TypeScript strict mode with `noUncheckedIndexedAccess: true` — all indexed access returns `T | undefined`, requiring explicit narrowing

#### Dashboard Layout

App.tsx orchestrates three containers in a single-page layout:

1. **Container1** — Feature statistics (donut charts for Blocks, 2D Parcels, 3D Parcels active/retired counts). Blocks donut hides when a block is selected.
2. **Container2** — Block filter (search by BlockNumber + SubBlockNumber). Handles duplicate results via a modal selector. Selecting a block enables Container3.
3. **Container3** — Linked analytics panel (appears only when a block is selected). Dropdown switches between three metric views:
   - `OwnershipMetric` — ownership breakdown chart + map
   - `CadastralDiaryMetric` — cadastral processes chart + map
   - `PAIMetric` — parcel accuracy histogram + color-coded map

Each metric component independently fetches its API data and renders both a chart (Recharts) and a MapView (MapLibre). The `MapView` component is generic: it accepts a GeoJSON FeatureCollection, a `colorProperty` for fill styling, and an optional `labelProperty`.

#### Auth Flow

Google credential → `POST /api/auth/verify` → server returns JWT + user info → JWT stored in `localStorage("auth_token")` → all API calls add `Authorization: Bearer <token>` header via `client/src/api/client.ts`.

### Server (`server/`) — Express + TypeScript

- Uses `tsx watch` for dev mode (hot reload)
- ESM module — all internal imports require `.js` extension (e.g., `from "./db/connection.js"`)
- **mssql** driver connecting to MS SQL Server (`BankalModProd` / `MNCDB`)
- All queries target `sde.Default` version (ArcGIS branch versioning)
- Database tables live in the `PF` schema: `PF.Blocks`, `PF.Parcels2D`, `PF.BorderPoints`
- Active records filtered by `WHERE RetiredByRecord IS NULL`
- Spatial operations use T-SQL `STIntersects()` / `STAsText()` — geometry returned as WKT, converted to GeoJSON server-side (inline `wktToGeoJSON` in route files, handles POLYGON and MULTIPOLYGON)
- **Tabu Ownership API**: fetched once at startup from `data.gov.il`, cached in memory with file fallback at `server/data/tabu-cache.json`. Server starts even if DB or ownership API fail.
- Auth: Google credential decoded from base64url payload (no library verification), domain-restricted to `@mapi.gov.il`, JWT issued with `jsonwebtoken`
- `dotenv` loads from `path.resolve(__dirname, ".env")` — in dev (`tsx watch`) this resolves to `server/src/.env` but symlinks to `server/.env`; place the actual file at `server/.env`

### API Routes

| Route | Purpose |
|-------|---------|
| `POST /api/auth/verify` | Google SSO verification + JWT |
| `GET /api/blocks/stats` | Active/retired block counts |
| `GET /api/blocks/search?blockNumber=&subBlockNumber=` | Find active blocks |
| `GET /api/parcels/:blockGlobalId` | Parcels with GeoJSON geometry |
| `GET /api/parcels2d/stats`, `/api/parcels3d/stats` | Feature counts |
| `GET /api/processes/:blockGlobalId` | Cadastral process borders |
| `GET /api/pai/:blockGlobalId` | Parcel Accuracy Index (spatial join) |
| `GET /api/ownership` | Cached Tabu ownership data |
| `GET /api/health` | Health check (always returns `{status: "ok"}`) |

All routes except `/api/auth/verify` and `/api/health` require a valid JWT via the `requireAuth` middleware.

### Key Domain Concepts

- **PAI (Parcel Accuracy Index)**: `PAI = (1/N) * Σ M(ci)` — weighted mean of boundary point classes. Class weights: 1→1, 12→2, 13→3, 24→4, NULL→4. Parcels with <3 points excluded.
- **Ownership matching**: concatenated key `<ParcelNumber/BlockNumber/SubBlockNumber>` joins parcels to Tabu API records.

## Environment Variables

Server requires `server/.env` (see `.env.example` at root):
- `DB_SERVER`, `DB_NAME`, `DB_USER`, `DB_PASSWORD` — MS SQL connection
- `GOOGLE_CLIENT_ID` — same value as client
- `JWT_SECRET` — signing key for session tokens
- `PORT` — defaults to 3001

## Specification

Full requirements in `docs/Specification & Documentation-Linda.docx` (binary .docx — read with `python-docx` if needed).

## Apply changes

Whenever the app’s build command is executed—whether manually by me or independently by the Claude agent—the following steps must always be performed:
1.Build the application using the development/source files.
2.Update the client files (the dist folder) with the results of the build.
3.Commit and push all changes to the Git repository on the Agent branch.

The custom build command should execute these steps automatically without asking for my permission or confirmation each time.
