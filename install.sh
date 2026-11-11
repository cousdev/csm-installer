#!/bin/bash

set -euo pipefail

APP_NAME="CSM"
INSTALL_DIR="$HOME/Library/Application Support"
REPO="cousdev/csm-installer"

LATEST_URL="https://github.com/$REPO/releases/latest"

echo "[INFO] Checking latest version..."

VERSION=$(curl -fsSI "$LATEST_URL" \
    | awk 'BEGIN {IGNORECASE=1} /^location:/ {print $2}' \
    | tr -d '\r' \
    | sed 's|.*/tag/||')

if [[ -z "$VERSION" ]]; then
    echo "[ERROR] Could not determine latest version."
    exit 1
fi

DOWNLOAD_URL="https://github.com/$REPO/releases/download/$VERSION/$APP_NAME"

echo "[INFO] Latest version: $VERSION"
echo "[INFO] Downloading $APP_NAME..."

mkdir -p "$INSTALL_DIR"

curl -fsSL "$DOWNLOAD_URL" \
    -o "$INSTALL_DIR/$APP_NAME"

chmod 755 "$INSTALL_DIR/$APP_NAME"

if ! grep -qF "$INSTALL_DIR" "$HOME/.zshrc" 2>/dev/null; then
    echo "export PATH=\"$INSTALL_DIR/cous:\$PATH\"" >> "$HOME/.zshrc"
fi

echo "[SUCCESS] Installed $APP_NAME ($VERSION)!"
echo "Run: $APP_NAME"
echo "You need to restart your terminal for changes to take effect. Run:"
echo "source ~/.zshrc"