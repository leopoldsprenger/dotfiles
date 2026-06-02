#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
SCRIPTS_DIR="${SCRIPTS_DIR:-$DOTFILES_DIR/scripts}"

backup_if_exists() {
  local file="$1"
  if [ -f "$file" ] || [ -d "$file" ]; then
    mv "$file" "$file.bak.$(date +%s)"
    echo "Backed up $file"
  fi
}

symlink() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  ln -sf "$src" "$dest"
  echo "Symlinked $dest → $src"
}

create_directories() {
  echo "Creating required directories..."
  mkdir -p ~/.config
  mkdir -p "$HOME/Library/Application Support/Code/User"
  mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
  mkdir -p ~/.config/linearmouse
}

backup_configs() {
  echo "Backing up existing configs..."
  backup_if_exists ~/.bash_profile
  backup_if_exists ~/.bashrc
  backup_if_exists ~/.zshrc
  backup_if_exists ~/.zprofile
  backup_if_exists ~/.gitconfig
}

symlink_bash() {
  echo "Setting up Bash configs..."
  symlink "$DOTFILES_DIR/bash/bash_profile" ~/.bash_profile
  symlink "$DOTFILES_DIR/bash/bashrc" ~/.bashrc
}

symlink_zsh() {
  echo "Setting up Zsh configs..."
  symlink "$DOTFILES_DIR/zsh/zshrc" ~/.zshrc
  symlink "$DOTFILES_DIR/zsh/zprofile" ~/.zprofile
  symlink "$DOTFILES_DIR/ohmyposh" ~/.config/ohmyposh
}

symlink_git() {
  echo "Setting up Git configs..."
  symlink "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig
  symlink "$DOTFILES_DIR/git/gitignore_global" ~/.gitignore_global
}

symlink_vscode() {
  echo "Setting up VS Code configs..."
  local vscode_user="$HOME/Library/Application Support/VSCodium/User"
  mkdir -p "$vscode_user"
  symlink "$DOTFILES_DIR/vscode/settings.json" "$vscode_user/settings.json"
  symlink "$DOTFILES_DIR/vscode/keybindings.json" "$vscode_user/keybindings.json"
}

install_vscode_extensions() {
  if command -v code >/dev/null 2>&1; then
    echo "Installing VS Code extensions..."
    bash "$SCRIPTS_DIR/vscode.sh" install || true
  else
    echo "VS Code not found, skipping extensions."
  fi
}

symlink_neovim() {
  echo "Setting up Neovim config..."
  symlink "$DOTFILES_DIR/nvim" ~/.config/nvim
}

symlink_aerospace() {
  echo "Setting up AerospaceWM config..."
  symlink "$DOTFILES_DIR/aerospace" ~/.config/aerospace
}

symlink_sketchybar() {
  echo "Setting up SketchyBar config..."
  symlink "$DOTFILES_DIR/sketchybar" ~/.config/sketchybar
}

symlink_janky_borders() {
  echo "Setting up Janky Borders..."
  symlink "$DOTFILES_DIR/janky-borders" ~/.config/borders
}

symlink_ghostty() {
  echo "Setting up Ghostty config..."
  symlink "$DOTFILES_DIR/ghostty/config" \
          "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
}

symlink_linearmouse() {
  echo "Setting up Linearmouse config..."
  symlink "$DOTFILES_DIR/linearmouse/linearmouse.json" \
          "$HOME/.config/linearmouse/linearmouse.json"
}

install_pico8() {
  echo "Installing Pico-8..."
  bash "$SCRIPTS_DIR/pico8.sh" all
}

create_directories
backup_configs

symlink_bash
symlink_zsh
symlink_git
symlink_vscode
install_vscode_extensions
symlink_neovim
symlink_aerospace
symlink_sketchybar
symlink_janky_borders
symlink_ghostty
symlink_linearmouse
install_pico8
