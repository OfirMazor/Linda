---
name: organize-files
description: Audit and organize project files — check that every file is in its correct folder, relocate misplaced files, create new folders for "floating" files, and detect dead/useless files (unreferenced code, stale assets, empty placeholders, leftover artifacts). Use when asked to organize, tidy, clean up, audit, or find unused files in the project.
---

# File Organization Skill

Audit the Linda project's file tree, verify each file lives in the correct location according to the canonical structure below, and fix any misplacements. Files that don't fit an existing folder get a new purpose-built folder created for them.

## Canonical Project Structure

```
Linda/
├── .claude/               # Claude Code configuration & skills
│   ├── docs/              # Reference documents (specs, schemas, images)
│   ├── settings.json
│   └── skills/            # Skill definitions
├── client/                # React + Vite frontend workspace
│   ├── src/
│   │   ├── api/           # API client modules (*.ts)
│   │   ├── assets/        # Static assets used by components (images, SVGs)
│   │   ├── auth/          # Auth components + styles (LoginScreen, etc.)
│   │   ├── components/    # UI components organized by container/feature
│   │   │   ├── common/    # Shared/reusable components (Modal, Spinner, Tooltip)
│   │   │   ├── Container1/
│   │   │   ├── Container2/
│   │   │   ├── Container3/
│   │   │   ├── Header/
│   │   │   └── MapView/
│   │   ├── hooks/         # Custom React hooks (useAuth, useBlockMetrics)
│   │   ├── styles/        # Global CSS (variables.css, global.css)
│   │   └── types/         # TypeScript type definitions (index.ts)
│   ├── public/            # Vite public static files (favicon, etc.)
│   ├── index.html
│   ├── package.json
│   ├── vite.config.ts
│   └── tsconfig.json
├── server/                # Express + TypeScript backend workspace
│   ├── src/
│   │   ├── db/            # Database connection and query helpers
│   │   ├── middleware/    # Express middleware (auth.ts)
│   │   ├── routes/        # Route handlers (one file per resource)
│   │   ├── services/      # Business logic services (ownership.ts)
│   │   └── utils/         # Utility functions (geometry.ts)
│   ├── data/              # Runtime cache files (tabu-cache.json)
│   ├── package.json
│   └── tsconfig.json
├── scripts/               # Build/dev tooling scripts
│   └── _stubs/            # Stub modules for bundling
├── docs/                  # Project documentation
│   ├── images/            # Doc images (logos, diagrams)
│   └── screenshots/       # App screenshots
├── fonts/                 # Custom font files (.ttf, .woff, .woff2)
├── dist/                  # Production build output (gitignored content)
├── .env.example           # Environment variable template
├── .gitignore
├── CLAUDE.md              # Claude Code project instructions
├── README.md              # Project readme
├── package.json           # Root workspace package.json
├── package-lock.json
├── start-linda.bat        # Quick-launch script
└── linda-app.bat          # App launcher
```

## File Placement Rules

Apply these rules in order. The FIRST matching rule wins.

### By location context

| File pattern | Correct location | Notes |
|---|---|---|
| `*.tsx` + matching `*.css` | `client/src/components/<FeatureDir>/` | Component + its styles stay together |
| `*.tsx` with `use` prefix | `client/src/hooks/` | Custom hooks |
| `*.css` (global/variables) | `client/src/styles/` | Only global.css, variables.css |
| `*.ts` (type definitions only) | `client/src/types/` | Pure type/interface files |
| `*.ts` (API client code) | `client/src/api/` | Fetch wrappers, API helpers |
| Server route files | `server/src/routes/` | One per resource |
| Server middleware | `server/src/middleware/` | Auth, logging, etc. |
| Server services | `server/src/services/` | Business logic, external API clients |
| Server utilities | `server/src/utils/` | Pure utility functions |
| DB connection/query | `server/src/db/` | Database layer |

### By file extension

| Extension | Correct location |
|---|---|
| `.ttf`, `.woff`, `.woff2`, `.otf` | `fonts/` (project-level) or `client/src/assets/` (if only used by client) |
| `.svg`, `.png`, `.jpg` (used in components) | `client/src/assets/` |
| `.svg`, `.png`, `.jpg` (documentation) | `docs/images/` |
| `.sql` | `.claude/docs/Database Schema/` |
| `.docx`, `.pdf` (specs) | `.claude/docs/` |
| `.bat`, `.ps1`, `.sh` (launchers) | Project root |
| `.mjs`, `.js` (build scripts) | `scripts/` |
| `.html` (non-app) | Evaluate — preview/demo files go to `docs/`, app entry stays at `client/index.html` |

### Root-level file whitelist

Only these files belong at the project root:

- `package.json`, `package-lock.json`
- `.env.example`, `.gitignore`
- `CLAUDE.md`, `README.md`
- `*.bat` launcher scripts (`start-linda.bat`, `linda-app.bat`)
- `splash.ps1` (launcher helper)

Any other file at root is a **floating file** that needs relocation.

## Dead File Detection

In addition to placement checks, identify **dead files** — files that exist in the project but serve no purpose. These are files that are not imported, not referenced, not used at runtime, and not required by any build tool.

### Categories of dead files

| Category | Description | How to detect |
|----------|-------------|---------------|
| **Orphaned code** | `.ts`/`.tsx`/`.css` files not imported by any other file | `grep -r` for the filename/module across all source files — zero hits = dead |
| **Stale assets** | Images, fonts, or media not referenced in code, HTML, or CSS | `grep -r` for the filename in all `.tsx`, `.css`, `.html`, `.ts` files |
| **Leftover artifacts** | Build outputs, temp files, logs, or cache files committed by mistake | Match patterns: `*.log`, `*.tmp`, `*.bak`, `*.old`, `*.orig`, `*.tsbuildinfo` (outside workspace root) |
| **Placeholder/empty files** | Files with no meaningful content (0 bytes, only whitespace, only comments) | Check file size and content |
| **Superseded files** | Old versions kept alongside the replacement (e.g., `utils-old.ts`, `Header-backup.tsx`) | Name patterns: `*-old.*`, `*-backup.*`, `*-copy.*`, `*.bak`, `*_v1.*`, `*_deprecated.*` |
| **Unreachable configs** | Config/env files for tools not used in the project | Check if the tool they configure is actually in `package.json` or used anywhere |

### Detection procedure

For each source file (`.ts`, `.tsx`, `.css`, `.js`, `.mjs`), check if it's referenced:

```bash
# For a file like "client/src/components/SomeWidget/SomeWidget.tsx":
# 1. Search for import of its module name (without extension)
grep -r "SomeWidget" --include="*.ts" --include="*.tsx" --include="*.css" --include="*.html" .

# 2. For CSS files, check if imported in their co-located component
grep -r "SomeWidget.css" --include="*.tsx" --include="*.ts" .

# 3. For assets (images, fonts), search all code + CSS + HTML
grep -r "survey-of-israel-logo" --include="*.tsx" --include="*.ts" --include="*.css" --include="*.html" .
```

### Exceptions — files that look dead but are NOT

Do NOT flag these as dead:
- **Entry points**: `main.tsx`, `index.ts`, `index.html`, `App.tsx` — these are root imports
- **Config files**: `vite.config.ts`, `tsconfig.json`, `.env`, `package.json`
- **Type declaration files**: `vite-env.d.ts`, `*.d.ts` — used implicitly by TypeScript
- **Cache/data files used at runtime**: `server/data/tabu-cache.json` — written/read by server code
- **Skill files**: anything in `.claude/skills/` or `.claude/docs/`
- **Git/tooling files**: `.gitignore`, `.env.example`
- **Build stubs**: `scripts/_stubs/*` — intentionally empty, used by bundler

### Reporting dead files

Add a `DEAD` status to the findings table:

```
| File | Status | Category | Evidence | Suggested Action |
```

Evidence should state what was searched for and that zero references were found.

Suggested actions:
- **Delete** — file is clearly useless (empty, temp, backup)
- **Verify with user** — file might have an undocumented purpose (looks like real code but nothing imports it)
- **Archive** — file has historical value but shouldn't be in the active tree (move to a `_deprecated/` folder or delete with a note in the commit message)

## Procedure

When invoked, run these steps:

### 1. Scan

List all tracked and untracked files (excluding `node_modules/`, `dist/`, `.git/`):

```bash
find . -type f \
  -not -path "*/node_modules/*" \
  -not -path "*/dist/*" \
  -not -path "*/.git/*" \
  -not -path "*/client/dist/*" \
  -not -path "*/server/dist/*" \
  | sort
```

### 2. Classify each file

For every file, determine:
- **Correct?** — Is it in the right folder per the rules above?
- **Misplaced?** — Does it belong in a different existing folder?
- **Floating?** — Does it not fit any existing folder?
- **Dead?** — Is it unreferenced, empty, or otherwise useless? (see Dead File Detection above)

### 3. Report findings

Present a table to the user:

```
| File | Status | Current Location | Suggested Location | Reason |
```

Statuses: `OK`, `MISPLACED`, `FLOATING`, `DEAD`

### 4. Propose actions

For misplaced files:
- `git mv <old-path> <new-path>`

For floating files:
- Create a new appropriately-named folder
- Move the file there
- Explain the folder's purpose

For dead files:
- `git rm <path>` — for clearly useless files (empty, temp, backup)
- Ask user to confirm — for files that look dead but might have undocumented purpose
- Note what evidence was checked (which greps returned zero hits)

### 5. Execute (with confirmation)

Ask the user before moving files. Present the full list of moves, then execute after approval. Update any import paths in code that reference moved files.

### 6. Post-move validation

After moves, verify:
- No broken imports (`grep` for old paths in `.ts`, `.tsx`, `.css` files)
- Build still passes: `npm run build` (from project root)
- Git status is clean (all moves tracked)

## Handling special cases

- **`splash-preview.html`** at root: This is a standalone preview file. If it's only used for development previewing the splash screen, suggest moving to `docs/` or a `dev/` folder.
- **Duplicate images**: If the same image exists in multiple locations (e.g., `client/src/assets/` and `docs/images/`), keep ONE canonical copy and reference it from other locations, or keep both if they serve different purposes (build-time asset vs. documentation).
- **Config files** (`.env`, `tsconfig.json`, `vite.config.ts`): These MUST stay in their current workspace root. Never move config files.
- **Generated files** (`*.tsbuildinfo`, lock files): Leave in place — these are managed by tools.

## Creating new folders

When creating a folder for floating files, follow these naming conventions:
- Lowercase, kebab-case
- Descriptive of contents (e.g., `dev-tools/`, `splash/`, `branding/`)
- Place at the most logical level in the hierarchy

Always add the new folder to this skill's canonical structure section so future runs recognize it.
