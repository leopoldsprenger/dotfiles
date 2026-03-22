#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"
SCRIPTS_DIR="$DOTFILES/scripts"

echo "Checking for dotfiles directory..."
if [ ! -d "$DOTFILES" ]; then
  echo "Dotfiles directory not found at $DOTFILES"
  exit 1
fi

mkdir -p "$BACKUP_DIR"

backup_if_exists() {
  local target="$1"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up existing $target"
    mv "$target" "$BACKUP_DIR/"
  fi
}

echo "Chmodding all scripts for manual use..."
chmod +x "$DOTFILES/scripts/*"

# homebrew
bash "$SCRIPTS_DIR/brew.sh" install_brew
bash "$SCRIPTS_DIR/brew.sh" install

# mouse utils
bash "$SCRIPTS_DIR/mousecape_install.sh"
bash "$SCRIPTS_DIR/cursorcerer_configure.sh"

# symlinking dotfiles
bash "$SCRIPTS_DIR/symlinks_create.sh"

# Raycast
bash "$SCRIPTS_DIR/raycast_configure.sh"

# configure brew and login services
bash "$SCRIPTS_DIR/services_configure.sh"

# macos system settings
bash "$SCRIPTS_DIR/macos_settings_configure.sh"

echo "Boot strap complete. Please restart your PC for all changes to take effect."
