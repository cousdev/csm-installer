#!/bin/bash

set -euo pipefail

APP_NAME="CSM"
INSTALL_DIR="/private/tmp/cous"
REPO="cousdev/csm-installer"

# Make it so that VERSION dynamically resolves eventually.
VERSION="v1.0.2"

DOWNLOAD_URL="https://github.com/$REPO/releases/download/$VERSION/$APP_NAME"

echo "[INFO] Downloading $APP_NAME..."

mkdir -p "$INSTALL_DIR"

curl -fsSL "$DOWNLOAD_URL" \
    -o "$INSTALL_DIR/$APP_NAME"

chmod 755 "$INSTALL_DIR/$APP_NAME"

if ! grep -qF "$INSTALL_DIR" "$HOME/.zshrc" 2>/dev/null; then
    echo 'export PATH="/private/tmp/cous:$PATH"' >> "$HOME/.zshrc"
fi

echo "[SUCCESS] Installation complete!"
echo "Run: $APP_NAME"
echo "You may need to restart your terminal."