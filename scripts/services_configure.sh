#!/usr/bin/env bash
set -euo pipefail

start_services() {
  echo "Starting SketchyBar service..."
  brew services start sketchybar || true

  echo "Starting Borders service..."
  brew services start borders || true
}

add_login_item() {
  echo "Adding AeroSpace to login items..."
  osascript -e 'tell application "System Events" to make login item at end with properties {name:"AeroSpace", hidden:false}'
}

start_services
add_login_item
