#!/usr/bin/env bash
set -euo pipefail

PICO8_APP="/Applications/PICO-8.app"
PICO8_BIN="/Applications/PICO-8.app/Contents/MacOS/pico8"
PICO8_URL="https://www.lexaloffle.com/dl/7tiann/pico-8_0.2.5g_osx.zip"

WRAPPER_PATH="/opt/homebrew/bin/pico8"

usage() {
  cat <<EOF
Usage: $0 <install|install_cli|all>
  install      Install PICO-8.app if not already installed
  install_cli  Install CLI wrapper for pico8
  all          Install both app and CLI
EOF
  exit 1
}

install_app() {
  echo "Installing PICO-8 if not already installed..."

  if [ ! -d "$PICO8_APP" ]; then
    echo "PICO-8 not found, installing..."

    tmp="$(mktemp -d)"
    curl -L "$PICO8_URL" -o "$tmp/app.zip"
    unzip -q "$tmp/app.zip" -d "$tmp"
    sudo mv "$tmp/pico-8/PICO-8.app" /Applications/
    rm -rf "$tmp"

    echo "PICO-8 installed."
  else
    echo "PICO-8 already installed."
  fi
}

install_cli() {
  echo "Installing PICO-8 CLI wrapper if not already installed..."

  if ! command -v pico8 >/dev/null 2>&1; then
    sudo tee "$WRAPPER_PATH" >/dev/null <<'EOF'
#!/usr/bin/env bash

PICO8_BIN="/Applications/PICO-8.app/Contents/MacOS/pico8"

if [ ! -f "$PICO8_BIN" ]; then
  echo "Error: PICO-8 binary not found at $PICO8_BIN"
  exit 1
fi

exec "$PICO8_BIN" "$@"
EOF

    sudo chmod +x "$WRAPPER_PATH"

    echo "PICO-8 CLI wrapper installed at $WRAPPER_PATH"
  else
    echo "PICO-8 CLI already installed."
  fi
}

mode="${1:-}"
if [ -z "$mode" ]; then usage; fi

case "$mode" in
  install) install_app ;;
  install_cli) install_cli ;;
  all)
    install_app
    install_cli
    ;;
  *) echo "Invalid mode: $mode" >&2; usage ;;
esac
