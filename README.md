# ai-governance-template

Template factory for multi-agent AI governance files. Compatible with Claude Code (WSL), Gemini CLI (Windows), Antigravity (Windows), Perplexity (GitHub MCP).

## Usage

### WSL / Linux
```bash
git clone https://github.com/maxmad64bis/ai-governance-template ~/ai-governance-template
cd ~/ai-governance-template
bash bootstrap-app.sh
```

### Windows (Gemini CLI / Antigravity)
```powershell
git clone https://github.com/maxmad64bis/ai-governance-template D:\git\ai-governance-template
cd D:\git\ai-governance-template
.\bootstrap-app.ps1
```

## Placeholders

| Placeholder | Description |
|---|---|
| `{{APP_NAME}}` | Nom de l'application (ex: `ETFtracker`) |
| `{{REPO}}` | Chemin GitHub (ex: `maxmad64bis/ETFtracker`) |
| `{{STACK}}` | Stack technique (ex: `React · Node.js · Python`) |
| `{{STACK_CONSTRAINTS}}` | Contraintes stack (ex: `⛔ python3 = stub WindowsApps`) |
| `{{APP_DESCRIPTION}}` | Description courte (ex: `Suivi patrimoine ETF`) |
| `{{APP_CONTEXT}}` | Contexte gouvernance spécifique (optionnel) |

## Files generated

- `AGENTS.md` — instructions communes toutes IA
- `CLAUDE.md` — instructions Claude Code spécifiques
- `GOOGLE-AI.md` — infra Gemini/Antigravity (copiée telle quelle)
- `PERPLEXITY-SPACE.md` — instructions Perplexity
- `docs/ai/INDEX.md` — carte navigation docs/ai/
- `docs/ai/rule-governance.md` — ownership + rôles agents

## Agent access

| Agent | Method |
|---|---|
| Claude Code (WSL) | Clone `~/ai-governance-template/` |
| Gemini CLI (Windows) | Clone `D:\git\ai-governance-template\` |
| Antigravity (Windows) | UNC `\\wsl.localhost\Ubuntu-24.04\home\dizzle\ai-governance-template\` |
| Perplexity | GitHub MCP → `maxmad64bis/ai-governance-template` |
