#!/bin/bash

set -euo pipefail

APP_NAME="CSM"
INSTALL_DIR="$HOME/Library/Application Support/cous"
REPO="cousdev/csm-installer"

BINARY_PATH="$INSTALL_DIR/$APP_NAME"
ZSHRC="$HOME/.zshrc"

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

curl -fsSL "$DOWNLOAD_URL" -o "$BINARY_PATH"
chmod 755 "$BINARY_PATH"

if [[ -f "$BINARY_PATH" ]]; then
    echo "[INFO] Binary installed at $BINARY_PATH"
fi

# Only configure PATH on a fresh installation
if ! grep -qF "$INSTALL_DIR" "$ZSHRC" 2>/dev/null; then
    echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$ZSHRC"
    echo "[INFO] Added installation directory to PATH."
else
    echo "[INFO] PATH already configured. Skipping."
fi

echo "[SUCCESS] Installed $APP_NAME ($VERSION)!"
echo "Run: $APP_NAME"
echo "Restart your terminal or run: source ~/.zshrc"