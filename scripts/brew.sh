#!/usr/bin/env bash
set -euo pipefail

BREWFILE_DIR="${HOME}/dotfiles/brew"
BREWFILE="$BREWFILE_DIR/Brewfile"

usage() {
  cat <<EOF
Usage: $0 <dump|install|install_brew>
  dump         Export installed Homebrew formulae, casks, taps, and Brewfile
  install      Install everything from $BREWFILE
  install_brew Install Homebrew if it is missing
EOF
  exit 1
}

install_brew() {
  echo "Install homebrew..."
  if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed."
  else
    echo "Homebrew already installed."
  fi
}

dump() {
  mkdir -p "$BREWFILE_DIR"

  echo "Exporting installed formulae..."
  brew list --formula > "$BREWFILE_DIR/formulae.txt"

  echo "Exporting installed casks..."
  brew list --cask > "$BREWFILE_DIR/casks.txt"

  echo "Exporting tapped repositories..."
  brew tap > "$BREWFILE_DIR/taps.txt"

  echo "Dumping Brewfile..."
  brew bundle dump --file="$BREWFILE" --force
}

install() {
  echo "Installing homebrew packages..."
  if [ ! -f "$BREWFILE" ]; then
    echo "Error: Brewfile not found at $BREWFILE" >&2
    exit 2
  fi

  brew bundle install --file="$BREWFILE"
}

mode="${1:-}"
if [ -z "$mode" ]; then usage; fi

case "$mode" in
  dump) dump ;;
  install) install ;;
  install_brew) install_brew ;;
  *) echo "Invalid mode: $mode" >&2; usage ;;
esac
