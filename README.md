<p align="center">
  <img src="docs/images/Survey of Israel logo.jpg" alt="Survey of Israel" width="120" />
</p>

<h1 align="center">Linda</h1>
<p align="center"><strong>Land Indicators for Parcel-Driven Insights</strong></p>

<p align="center">
  A single-page cadastral analytics dashboard built by the National Cadaster Department<br/>
  at the <a href="https://www.mapi.gov.il">Survey of Israel</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/React-18-61DAFB?logo=react&logoColor=white" alt="React" />
  <img src="https://img.shields.io/badge/TypeScript-5-3178C6?logo=typescript&logoColor=white" alt="TypeScript" />
  <img src="https://img.shields.io/badge/Vite-6-646CFF?logo=vite&logoColor=white" alt="Vite" />
  <img src="https://img.shields.io/badge/Express-4-000000?logo=express&logoColor=white" alt="Express" />
  <img src="https://img.shields.io/badge/MapLibre_GL-4-396CB2?logo=maplibre&logoColor=white" alt="MapLibre" />
  <img src="https://img.shields.io/badge/SQL_Server-2019-CC2927?logo=microsoftsqlserver&logoColor=white" alt="SQL Server" />
</p>

---

## Overview

**Linda** visualizes cadastral data — land parcels, ownership records, surveying processes, and boundary accuracy — through interactive charts and spatial maps. It serves as an operational intelligence tool for cadaster professionals managing Israel's national land registry.

### Key Capabilities

- **Feature Statistics** — Real-time counts of active/retired blocks, 2D parcels, and 3D parcels
- **Block Search** — Look up any cadastral block by number with instant parcel rendering
- **Ownership Analysis** — Ring chart + color-coded map showing governmental, private, mixed, and unknown land distribution
- **Cadastral Diary** — Timeline visualization of all registered processes (subdivisions, consolidations, corrections) with toggleable map layers
- **Parcel Accuracy Index (PAI)** — Histogram + heatmap measuring boundary point precision per parcel
- **Light/Dark Theme** — Full dual-theme support with CSS custom properties
- **Google SSO** — Domain-restricted authentication (`@mapi.gov.il`)

---

## Screenshots

> Replace placeholders with actual screenshots saved in `docs/screenshots/`

| Login Screen | Dashboard |
|:---:|:---:|
| ![Login](docs/screenshots/login.png) | ![Dashboard](docs/screenshots/dashboard.png) |

| Ownership Metric | PAI Metric |
|:---:|:---:|
| ![Ownership](docs/screenshots/ownership-metric.png) | ![PAI](docs/screenshots/pai-metric.png) |

| Cadastral Diary | Dark Mode |
|:---:|:---:|
| ![Diary](docs/screenshots/cadastral-diary.png) | ![Dark Mode](docs/screenshots/dark-mode.png) |

---

## Architecture

```
linda/
├── client/                 # React + TypeScript + Vite
│   ├── src/
│   │   ├── auth/           # Google SSO login screen
│   │   ├── components/
│   │   │   ├── Container1/ # Feature statistics (donut charts)
│   │   │   ├── Container2/ # Block search & filter
│   │   │   ├── Container3/ # Metric views (Ownership, Diary, PAI)
│   │   │   ├── Header/     # App header, theme toggle, user info
│   │   │   ├── MapView/    # Generic MapLibre GL component
│   │   │   └── common/     # Shared UI (Spinner, Modal, InfoTooltip)
│   │   ├── hooks/          # useAuth, useBlockMetrics
│   │   ├── styles/         # Global CSS + theme variables
│   │   └── types/          # TypeScript interfaces
│   └── vite.config.ts
│
├── server/                 # Express + TypeScript
│   └── src/
│       ├── db/             # MSSQL connection pool
│       ├── middleware/     # JWT auth guard
│       ├── routes/         # REST API endpoints
│       ├── services/       # Ownership data cache (Tabu API)
│       └── utils/          # WKT → GeoJSON converter
│
├── scripts/                # Build tooling (portable exe bundler)
├── docs/                   # Specification & screenshots
└── package.json            # Workspace root
```

### Data Flow

```
┌─────────────┐      ┌──────────────┐      ┌──────────────────┐
│   Browser   │─────▶│  Express API │─────▶│  MS SQL Server   │
│  (React +   │◀─────│  (port 3001) │◀─────│  (ArcGIS SDE)    │
│  MapLibre)  │      └──────┬───────┘      └──────────────────┘
└─────────────┘             │
                            │ startup cache
                            ▼
                    ┌───────────────┐
                    │  data.gov.il  │
                    │  (Tabu API)   │
                    └───────────────┘
```

---

## Getting Started

### Prerequisites

| Requirement | Version |
|-------------|---------|
| Node.js | 18+ |
| npm | 9+ |
| MS SQL Server | 2016+ (with spatial types) |
| Google Cloud Console | OAuth 2.0 Client ID |

### Installation

```bash
# Clone the repository
git clone https://github.com/OfirMazor/Linda.git
cd Linda

# Install all dependencies (workspaces: client + server)
npm install
```

### Configuration

Create `server/.env` from the example:

```bash
cp .env.example server/.env
```

Fill in the required values:

```env
DB_SERVER=your-sql-server-host
DB_NAME=your-database-name
DB_USER=your-db-username
DB_PASSWORD=your-db-password
GOOGLE_CLIENT_ID=your-google-client-id
JWT_SECRET=your-jwt-secret
PORT=3001
```

Create `client/.env`:

```env
VITE_GOOGLE_CLIENT_ID=your-google-client-id
```

### Running

```bash
# Development (hot reload on both client & server)
npm run dev

# Or run individually:
npm run dev:client    # Vite → http://localhost:5173
npm run dev:server    # Express → http://localhost:3001
```

The Vite dev server proxies all `/api/*` requests to the Express backend automatically.

### Building for Production

```bash
# Standard build
npm run build

# Portable distribution (no Node.js install required on target)
npm run build:exe
```

The `build:exe` script produces a self-contained `dist/` folder (~90MB) with:
- `node.exe` — portable Node.js runtime
- `server.cjs` — bundled server
- `client/` — static frontend assets
- `linda.bat` — double-click launcher

---

## API Reference

All endpoints except `/api/auth/verify` and `/api/health` require a valid JWT via `Authorization: Bearer <token>`.

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/auth/verify` | Verify Google credential, return JWT |
| `GET` | `/api/health` | Health check |
| `GET` | `/api/blocks/stats` | Active/retired block counts |
| `GET` | `/api/blocks/search?blockNumber=&subBlockNumber=` | Search blocks |
| `GET` | `/api/parcels/:blockGlobalId` | Parcels with GeoJSON geometry |
| `GET` | `/api/parcels2d/stats` | 2D parcel counts |
| `GET` | `/api/parcels3d/stats` | 3D parcel counts |
| `GET` | `/api/processes/:blockGlobalId` | Cadastral process boundaries |
| `GET` | `/api/pai/:blockGlobalId` | Parcel Accuracy Index data |
| `GET` | `/api/ownership` | Cached Tabu ownership records |

---

## Domain Concepts

### Parcel Accuracy Index (PAI)

A weighted mean measuring the spatial precision of a parcel's boundary points:

```
PAI = (1/N) × Σ M(ci)
```

| Point Class | Weight | Meaning |
|:-----------:|:------:|---------|
| 1 | 1 | Precise survey point |
| 12 | 2 | Good accuracy |
| 13 | 3 | Moderate accuracy |
| 24 | 4 | Low accuracy / estimated |
| NULL | 4 | Unknown / unclassified |

Lower PAI = better boundary accuracy. Parcels with fewer than 3 boundary points are excluded.

### Ownership Classification

Parcels are joined to the national Tabu registry via a composite key (`ParcelNumber/BlockNumber/SubBlockNumber`) and classified as:

| Type | Description |
|------|-------------|
| Governmental | State-owned land |
| Private | Privately held parcels |
| Mixed | Multiple ownership types |
| Other | Special designations |
| Unknown | No matching Tabu record |

---

## Tech Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| Frontend | React 18, TypeScript, Vite | SPA framework |
| Charts | Recharts | Donut/ring charts, histograms |
| Maps | MapLibre GL JS | Vector map rendering with GeoJSON |
| Auth | @react-oauth/google | Google SSO integration |
| Backend | Express, TypeScript | REST API server |
| Database | MS SQL Server (mssql) | Spatial queries via T-SQL |
| Spatial | STIntersects, STAsText | Server-side geometry operations |
| External | data.gov.il Tabu API | National ownership registry |

---

## Deployment

### Quick Start (Windows)

```bash
# Double-click or run:
start-linda.bat
```

### Portable Distribution

After building with `npm run build:exe`, copy the `dist/` folder to any Windows x64 machine:

1. Rename `.env.example` → `.env`
2. Fill in database credentials
3. Double-click `linda.bat`

No Node.js installation required on the target machine.

---

## Branch Strategy

| Branch | Purpose |
|--------|---------|
| `main` | Stable baseline — production-ready code |
| `Agent` | Active development — updated with each build |

---

## License

Internal tool — Survey of Israel, National Cadaster Department.

---

<p align="center">
  <sub>Built with data-driven purpose for Israel's national land registry</sub>
</p>
