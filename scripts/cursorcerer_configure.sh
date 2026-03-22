#!/usr/bin/env bash
set -euo pipefail

BUNDLE_ID="com.doomlaser.cursorcerer"
APP_NAME="Cursorcerer"

configure_cursorcerer() {
  echo "Configuring Cursorcerer..."

  echo "Setting idle hide to 3 seconds..."
  defaults write "$BUNDLE_ID" idleHide -string "3"

  echo "Disabling toggle hotkey..."
  defaults write "$BUNDLE_ID" toggleCursorHotKey -dict keyCode -int 0 modifiers -int 0

  # Restart app if running so changes take effect
  if pgrep -x "$APP_NAME" >/dev/null 2>&1; then
    echo "Restarting Cursorcerer..."
    killall "$APP_NAME" || true
    sleep 0.5
  fi

  echo "Cursorcerer configuration applied."
}

configure_cursorcerer
