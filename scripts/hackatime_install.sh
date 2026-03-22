#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE="$HOME/.wakatime.cfg"

if ! command -v wakatime-cli >/dev/null 2>&1; then
  echo "Error: wakatime-cli not found. Install via brew first."
  exit 1
fi

read -rsp "Enter your Hackatime API key: " API_KEY
echo

if [[ -z "$API_KEY" ]]; then
  echo "Error: API key cannot be empty."
  exit 1
fi

cat > "$CONFIG_FILE" <<EOF
[settings]
api_key = $API_KEY
api_url = https://hackatime.hackclub.com/api/hackatime/v1
heartbeat_rate_limit_seconds = 30
exclude_unknown_project = true
EOF

chmod 600 "$CONFIG_FILE"

echo "WakaTime config written to $CONFIG_FILE"

echo "Installing terminal-wakatime"
curl -fsSL http://hack.club/terminal-wakatime.sh | bash

echo "Hackatime setup complete."
