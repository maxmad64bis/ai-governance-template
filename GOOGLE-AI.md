# GOOGLE-AI.md — {{APP_NAME}} (Gemini CLI + Antigravity)
<!-- v2.0 {{DATE}} -->
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
| Vérifier nb lignes | `run_shell_command` → `wc -l` | `run_command` → `powershell -Command "(Get-Content <f>).Length"` |
| Enchaîner commandes shell | `&&` (indépendantes OK) | `;` — ⛔ `&&` non supporté PowerShell 5.1 |
| Avant commit | `git status && git diff HEAD` | `git status; git diff HEAD` |

## RÔLE & DIRECTIVES
Inquiry par défaut. Directive explicite pour toute modification fichier, commit ou push.

## INFRA & SWITCH

### Outillage checkpoint

| Agent | Comptes | Cmd switch | Hook auto | Checkpoint |
|---|---|---|---|---|
| Claude Code WSL | — | — | `PreCompact` | `~/.claude/CHECKPOINT.md` |
| Claude Code Win | — | — | `PreCompact` | `C:\Users\maxma\.claude\CHECKPOINT.md` |
| Gemini CLI | maxmad64 · maxmad64bis | `gemini1` / `gemini2` | `PreCompress` | `C:\Users\maxma\.gemini\tmp\{compte}\CHECKPOINT.md` |
| Antigravity | maxmad64 · maxmad64bis | `agy1` / `agy2` | `PreCompact` | `C:\Users\maxma\.gemini\antigravity-cli\tmp\{compte}\CHECKPOINT.md` |

Tous les scripts: git context auto-rempli · debounce 5 min · lock concurrent · max 10 backups.
Fallback compte (Gemini/Antigravity): si env var absente → compte avec CHECKPOINT.md le plus récent → `maxmad64` par défaut.

**Hooks checkpoint — implémentation (harmonisée):**

| Agent | Script | Fonctionnalités |
|---|---|---|
| Claude Code WSL | `~/.claude/hooks/checkpoint-precompact.js` | git context + reminder stdout + debounce 5min + lock + backup pruning |
| Claude Code Win | `C:\Users\maxma\.claude\hooks\checkpoint-precompact.js` | idem |
| Gemini CLI | `C:\Users\maxma\.gemini\hooks\checkpoint-precompress.js` | idem + fallback compte auto |
| Antigravity | `C:\Users\maxma\.gemini\antigravity-cli\hooks\checkpoint-precompact.js` | idem + section `## CHEMINS` UNC WSL auto-incluse |

### Auth switch — implémentation

| Agent | Mécanisme | Fichier actif | Creds sauvegardés |
|---|---|---|---|
| Gemini CLI | Symlink `oauth_creds.json` → `oauth_creds.{compte}.json` + màj `google_accounts.json` | `oauth_creds.json` | `~/.gemini/oauth_creds.{compte}.json` |
| Antigravity | Symlink `antigravity-oauth-token` → `agy-{compte}.json` | `antigravity-oauth-token` | `C:\Users\maxma\.gemini\tmp\creds\agy-{compte}.json` |

Symlink = pas de copie de données · token refreshes auto-écrits au fichier compte · atomique.
`switch-agy.ps1 {compte} -save` → copie token actif dans creds · `-save` résout le symlink avant copie (évite copie circulaire).
⚠️ `agy1`/`agy2` requièrent `sudo` pour créer symlinks (Developer Mode actif mais insuffisant hors session élevée).
Scripts switch: `C:\Users\maxma\switch-gemini.ps1` · `C:\Users\maxma\switch-agy.ps1`
Backups auto: `~/.claude/backups/` · `C:\Users\maxma\.gemini\tmp\{compte}\` · `C:\Users\maxma\.gemini\antigravity-cli\tmp\{compte}\` (max 10, timestamp)

### Antigravity — règles critiques
- Lancer via `agy1` ou `agy2` (jamais `agy` direct) → `ANTIGRAVITY_TEMP_DIR` requis
- Path UNC WSL repo: `\\wsl.localhost\Ubuntu-24.04\home\dizzle\{{APP_NAME}}` — utiliser ce path complet dans tout ListDir/Read/Write
- Après tout Write sur fichier source → vérifier `git diff HEAD` : blocs dupliqués > 3 lignes consécutives identiques = annuler + `git checkout HEAD -- <fichier>`

**WSL root ownership fix:**
- ⛔ Écriture Windows via UNC → fichiers `.git/` créés en root côté WSL
- Fix manuel : `sudo chown -R dizzle:dizzle /home/dizzle/{{APP_NAME}}/`
- Fix automatique : systemd path unit + service (voir `docs/ai/rule-infra` pour implémentation complète)
- ⚠️ Si `EACCES` sur fichiers source → ownership root non corrigé → fix manuel immédiat
