Build, commit, and push the Linda app to the Agent branch.

Workflow steps:
1. Run `npm run build` from the project root to build both client and server.
2. If the build fails, fix the issue and retry.
3. Stage all changed files (source + built output in `client/dist/`).
4. Create a git commit with a concise message describing what changed since the last commit.
5. Push to the `Agent` branch on origin.

Do NOT ask for confirmation at any step — execute the full pipeline automatically.
