#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
RAYCAST_CONFIG="$DOTFILES_DIR/raycast/backup.rayconfig"

if [ -f "$RAYCAST_CONFIG" ]; then
  echo "Configuring Raycast from $RAYCAST_CONFIG..."
  open "$RAYCAST_CONFIG"
else
  echo "Raycast backup not found, skipping."
fi
