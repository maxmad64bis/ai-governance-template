#!/usr/bin/env bash
# bootstrap-app.sh — Generate AI governance files for a new project
set -e

echo "=== AI Governance Template Bootstrap (WSL/Linux) ==="
echo ""
read -p "App name (ex: MyApp): " APP_NAME
read -p "GitHub repo (ex: user/repo): " REPO
read -p "Stack (ex: React · Node.js): " STACK
read -p "Stack constraints (optional, ex: ⛔ python3 stub): " STACK_CONSTRAINTS
read -p "App description (ex: Track family expenses): " APP_DESCRIPTION
read -p "Target directory (default: ~/$(echo $APP_NAME | tr '[:upper:]' '[:lower:]' | tr ' ' '-')): " TARGET_DIR

APP_LOWER=$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
TARGET_DIR="${TARGET_DIR:-$HOME/$APP_LOWER}"
DATE=$(date +%F)

echo ""
echo "Creating $TARGET_DIR ..."
mkdir -p "$TARGET_DIR/docs/ai"

TEMPLATE_DIR="$(dirname "$0")"

replace_placeholders() {
  local file="$1"
  sed -i \
    -e "s/{{APP_NAME}}/$APP_NAME/g" \
    -e "s/{{REPO}}/$REPO/g" \
    -e "s/{{STACK}}/$STACK/g" \
    -e "s/{{STACK_CONSTRAINTS}}/$STACK_CONSTRAINTS/g" \
    -e "s/{{APP_DESCRIPTION}}/$APP_DESCRIPTION/g" \
    -e "s/{{APP_CONTEXT}}//g" \
    -e "s/{{APP_WSL_PATH}}/$APP_LOWER/g" \
    -e "s/{{DATE}}/$DATE/g" \
    "$file"
}

for template in "$TEMPLATE_DIR"/*.template; do
  basename=$(basename "$template" .template)
  dest="$TARGET_DIR/$basename"
  cp "$template" "$dest"
  replace_placeholders "$dest"
  echo "  ✓ $basename"
done

for template in "$TEMPLATE_DIR"/docs/ai/*.template; do
  basename=$(basename "$template" .template)
  dest="$TARGET_DIR/docs/ai/$basename"
  cp "$template" "$dest"
  replace_placeholders "$dest"
  echo "  ✓ docs/ai/$basename"
done

cp "$TEMPLATE_DIR/GOOGLE-AI.md" "$TARGET_DIR/GOOGLE-AI.md"
sed -i -e "s/{{APP_NAME}}/$APP_NAME/g" -e "s/{{DATE}}/$DATE/g" -e "s/{{APP_WSL_PATH}}/$APP_LOWER/g" "$TARGET_DIR/GOOGLE-AI.md"
echo "  ✓ GOOGLE-AI.md"

echo ""
echo "=== Done! Next steps: ==="
echo "  cd $TARGET_DIR"
echo "  git init"
echo "  git add ."
echo "  git commit -m 'chore: init AI governance files'"
echo "  gh repo create $REPO --public"
echo "  git remote add origin https://github.com/$REPO.git"
echo "  git push -u origin main"
