#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/bin"

curl -fsSL \
  -o "$HOME/bin/open-project.sh" \
  https://raw.githubusercontent.com/leopoldsprenger/termtools/main/open-project.sh

chmod +x "$HOME/bin/open-project.sh"

echo "Installed open-project.sh to ~/bin"
