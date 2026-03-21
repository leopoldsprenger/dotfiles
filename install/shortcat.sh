
#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles/shortcat}"
PLIST_NAME="com.sproutcube.Shortcat.plist"
PLIST_PATH="$DOTFILES_DIR/$PLIST_NAME"
BUNDLE_ID="com.sproutcube.Shortcat"
APP_NAME="Shortcat"

usage() {
  cat <<EOF
Usage: $0 <dump|install|set_login>
  dump       Export Shortcat prefs to $PLIST_PATH (as XML)
  install    Import prefs from $PLIST_PATH into Shortcat
  set_login  Enable Shortcat auto-start on login by setting prefs key
EOF
  exit 1
}

dump() {
  mkdir -p "$DOTFILES_DIR"
  if defaults read "$BUNDLE_ID" >/dev/null 2>&1; then
    defaults export "$BUNDLE_ID" - | plutil -convert xml1 -o "$PLIST_PATH" -- -
    echo "Exported Shortcat prefs to $PLIST_PATH"
  else
    echo "No Shortcat preferences found to export." >&2
    exit 2
  fi
}

install() {
  if [ ! -f "$PLIST_PATH" ]; then
    echo "Config file not found: $PLIST_PATH" >&2
    exit 3
  fi

  defaults import "$BUNDLE_ID" "$PLIST_PATH"
  if pgrep -x "$APP_NAME" >/dev/null 2>&1; then
    killall "$APP_NAME" || true
    sleep 0.5
  fi
  open -a "$APP_NAME" || true
  echo "Imported Shortcat prefs from $PLIST_PATH and restarted Shortcat."
}

set_login() {
  # Set the launchAtLogin boolean in Shortcat prefs
  defaults write "$BUNDLE_ID" launchAtLogin -bool true

  # Ensure the change is picked up by the running app
  if pgrep -x "$APP_NAME" >/dev/null 2>&1; then
    killall "$APP_NAME" || true
    sleep 0.5
  fi
  open -a "$APP_NAME" || true

  echo "Set launchAtLogin=true for $BUNDLE_ID and restarted $APP_NAME."
}

if [ "${1:-}" = "" ]; then usage; fi

case "$1" in
  dump) dump ;;
  install) install ;;
  set_login) set_login ;;
  *) usage ;;
esac

