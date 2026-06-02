#!/usr/bin/env bash
set -euo pipefail

VSCODE_EXTENSIONS_FILE="${HOME}/dotfiles/vscode/extensions.txt"

usage() {
  cat <<EOF
Usage: $0 <dump|install>
  dump     Export currently installed VSCode extensions to $VSCODE_EXTENSIONS_FILE
  install  Install VSCode extensions listed in $VSCODE_EXTENSIONS_FILE
EOF
  exit 1
}

install() {
  if [ ! -f "$VSCODE_EXTENSIONS_FILE" ]; then
    echo "Error: VSCode extensions file not found: $VSCODE_EXTENSIONS_FILE" >&2
    exit 2
  fi

  echo "Installing VSCode extensions from $VSCODE_EXTENSIONS_FILE..."
  xargs -n 1 codium --install-extension < "$VSCODE_EXTENSIONS_FILE"
  echo "VSCode extensions installation complete."
}

dump() {
  echo "Exporting currently installed VSCode extensions to $VSCODE_EXTENSIONS_FILE..."
  mkdir -p "$(dirname "$VSCODE_EXTENSIONS_FILE")"
  codium --list-extensions > "$VSCODE_EXTENSIONS_FILE"
  echo "VSCode extensions exported."
}

mode="${1:-}"
if [ -z "$mode" ]; then usage; fi

case "$mode" in
  dump) dump ;;
  install) install ;;
  *) echo "Invalid mode: $mode" >&2; usage ;;
esac
