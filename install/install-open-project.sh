#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/bin"

TAG="v1.0.0"
REPO="leopoldsprenger/termtools"
ASSET="open-project.sh"
DIR="$HOME/bin"

if [ ! -f "$HOME/bin/$ASSET" ]; then
  gh release download "$TAG" --repo "$REPO" --pattern "$ASSET" --dir "$DIR"
  chmod +x "$DIR"
fi

echo "Installed $ASSET to $DIR"
