# GOOGLE-AI.md — {{APP_NAME}} (Gemini CLI + Antigravity)
<!-- v1.0 {{DATE}} -->
> **NE JAMAIS MODIFIER CE BLOC** (sauf accord humain explicite) — BLOC v1.
> Agis comme un expert en ingénierie de prompt. Réduis et compacte ces instructions au strict minimum de tokens. Structure Markdown ultra-dense, zéro transition, paires clé-valeur. 100 % intention opérationnelle.
> MISE À JOUR : modifier le CORPS du fichier uniquement. Ce bloc → VERBATIM.

Ce fichier couvre Gemini CLI et Antigravity. Règles communes → lire `AGENTS.md`.

## OUTILS SELON AGENT

| Action | Gemini CLI | Antigravity |
|---|---|---|
| Plan complexe (>3 fichiers) | `enter_plan_mode` | `implementation_plan` artifact |
| Lire fichier | `read_file` | `view_file` |
| Lire par morceaux | `start_line` / `end_line` | `StartLine` / `EndLine` |
| Enchaîner commandes shell | `&&` (indépendantes OK) | `;` — PowerShell 5.1 |
| Avant commit | `git status && git diff HEAD` | `git status; git diff HEAD` |

## RÔLE & DIRECTIVES
Inquiry par défaut. Directive explicite pour toute modification fichier, commit ou push.

## INFRA & SWITCH

### Outillage checkpoint

| Agent | Comptes | Cmd switch | Hook auto | Checkpoint |
|---|---|---|---|---|
| Claude Code WSL | — | — | `PreCompact` | `~/.claude/CHECKPOINT.md` |
| Gemini CLI | maxmad64 · maxmad64bis | `gemini1` / `gemini2` | `PreCompress` | `.gemini/tmp/{compte}/CHECKPOINT.md` |
| Antigravity | maxmad64 · maxmad64bis | `agy1` / `agy2` | `PreCompact` | `.gemini/antigravity-cli/tmp/{compte}/CHECKPOINT.md` |

Tous les scripts: git context auto-rempli · debounce 5 min · lock concurrent · max 10 backups.

### Auth switch
Gemini CLI: symlink `oauth_creds.json` → `oauth_creds.{compte}.json`.
Antigravity: symlink `antigravity-oauth-token` → `agy-{compte}.json`.
Scripts switch: `switch-gemini.ps1` · `switch-agy.ps1` (Windows `C:\Users\maxma\`).

### Antigravity — règles critiques
- Lancer via `agy1` ou `agy2` (jamais `agy` direct) → `ANTIGRAVITY_TEMP_DIR` requis
- Après tout Write sur fichier source → vérifier `git diff HEAD` : blocs dupliqués > 3 lignes = annuler + `git checkout HEAD -- <fichier>`
- Path UNC WSL repo: voir app-specific GOOGLE-AI.md pour le path complet
