#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

MOUSECAPE_APP="/Applications/Mousecape.app"
MOUSECAPE_ZIP="/Applications/Mousecape-Tahoe-PreRelease.zip"
MOUSECAPE_URL="https://github.com/AdamWawrzynkowskiGF/Mousecape-TahoeSupport/releases/download/PreRelease-v01/Mousecape-Tahoe-PreRelease.zip"

install_mousecape() {
  echo ""
  if [ ! -d "$MOUSECAPE_APP" ]; then
    echo "Mousecape not found, installing..."

    sudo curl -L -o "$MOUSECAPE_ZIP" "$MOUSECAPE_URL"
    sudo unzip -o "$MOUSECAPE_ZIP" -d /Applications
    sudo rm -f "$MOUSECAPE_ZIP"

    echo "Removing quarantine attribute..."
    sudo xattr -dr com.apple.quarantine "$MOUSECAPE_APP"

    echo "Mousecape installed."
  else
    echo "Mousecape already installed."

    echo "Ensuring quarantine attribute is removed..."
    sudo xattr -dr com.apple.quarantine "$MOUSECAPE_APP"
  fi
}

import_cursors() {
  echo "Importing cursor themes..."

  open -a Mousecape \
    "$DOTFILES_DIR/mousecape/vision.cursor.white.cape" \
    "$DOTFILES_DIR/mousecape/vision.cursor.black.cape"

  echo "Opening Mousecape..."
  open -a Mousecape
}

install_mousecape
import_cursors
