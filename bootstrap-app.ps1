# bootstrap-app.ps1 — Generate AI governance files for a new project (Windows)
param()

Write-Host "=== AI Governance Template Bootstrap (Windows) ===" -ForegroundColor Cyan
Write-Host ""
$APP_NAME = Read-Host "App name (ex: MyApp)"
$REPO = Read-Host "GitHub repo (ex: user/repo)"
$STACK = Read-Host "Stack (ex: React . Node.js)"
$STACK_CONSTRAINTS = Read-Host "Stack constraints (optional)"
$APP_DESCRIPTION = Read-Host "App description"
$APP_LOWER = $APP_NAME.ToLower() -replace ' ', '-'
$default_target = "D:\git\$APP_LOWER"
$TARGET_DIR = Read-Host "Target directory (default: $default_target)"
if (-not $TARGET_DIR) { $TARGET_DIR = $default_target }
$DATE = Get-Date -Format "yyyy-MM-dd"

Write-Host ""
Write-Host "Creating $TARGET_DIR ..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "$TARGET_DIR\docs\ai" | Out-Null

$TEMPLATE_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path

function Replace-Placeholders($file) {
  $content = Get-Content $file -Raw -Encoding UTF8
  $content = $content `
    -replace '\{\{APP_NAME\}\}', $APP_NAME `
    -replace '\{\{REPO\}\}', $REPO `
    -replace '\{\{STACK\}\}', $STACK `
    -replace '\{\{STACK_CONSTRAINTS\}\}', $STACK_CONSTRAINTS `
    -replace '\{\{APP_DESCRIPTION\}\}', $APP_DESCRIPTION `
    -replace '\{\{APP_CONTEXT\}\}', '' `
    -replace '\{\{APP_WSL_PATH\}\}', $APP_LOWER `
    -replace '\{\{DATE\}\}', $DATE
  Set-Content $file -Value $content -Encoding UTF8 -NoNewline
}

Get-ChildItem "$TEMPLATE_DIR\*.template" | ForEach-Object {
  $basename = $_.Name -replace '\.template$', ''
  $dest = "$TARGET_DIR\$basename"
  Copy-Item $_.FullName $dest
  Replace-Placeholders $dest
  Write-Host "  v $basename" -ForegroundColor Green
}

Get-ChildItem "$TEMPLATE_DIR\docs\ai\*.template" | ForEach-Object {
  $basename = $_.Name -replace '\.template$', ''
  $dest = "$TARGET_DIR\docs\ai\$basename"
  Copy-Item $_.FullName $dest
  Replace-Placeholders $dest
  Write-Host "  v docs/ai/$basename" -ForegroundColor Green
}

Copy-Item "$TEMPLATE_DIR\GOOGLE-AI.md" "$TARGET_DIR\GOOGLE-AI.md"
Replace-Placeholders "$TARGET_DIR\GOOGLE-AI.md"
Write-Host "  v GOOGLE-AI.md" -ForegroundColor Green

Write-Host ""
Write-Host "=== Done! Next steps: ===" -ForegroundColor Cyan
Write-Host "  cd $TARGET_DIR"
Write-Host "  git init"
Write-Host "  git add ."
Write-Host "  git commit -m 'chore: init AI governance files'"
Write-Host "  gh repo create $REPO --public"
Write-Host "  git remote add origin https://github.com/$REPO.git"
Write-Host "  git push -u origin main"
