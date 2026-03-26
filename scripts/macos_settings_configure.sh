#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
WALLPAPER_PATH="$DOTFILES_DIR/wallpapers/ghostty.png"

apply_defaults() {
  echo "Applying macOS UI defaults..."

  echo "Hiding menu bar..."
  defaults write NSGlobalDomain _HIHideMenuBar -bool true

  echo "Enabling Dock auto-hide..."
  defaults write com.apple.dock autohide -bool true

  echo "Setting Dock animation speed to 0..."
  defaults write com.apple.dock autohide-time-modifier -float 0

  echo "Restarting Dock..."
  killall Dock || true

  echo "macOS defaults applied."
}

set_wallpaper() {
  echo "Setting wallpaper..."

  if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "Error: Wallpaper not found at $WALLPAPER_PATH" >&2
    exit 2
  fi

  osascript <<EOF
tell application "System Events"
  tell every desktop
    set picture to "$WALLPAPER_PATH"
  end tell
end tell
EOF

  echo "Wallpaper set to $WALLPAPER_PATH"
}

apply_defaults
set_wallpaper
