#!/usr/bin/env bash

set -e

echo "==> Stopping nix-daemon..."
sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist 2>/dev/null || true

echo "==> Removing launch daemon..."
sudo rm -f /Library/LaunchDaemons/org.nixos.nix-daemon.plist

echo "==> Removing nix profiles and system links..."
sudo rm -rf /nix

echo "==> Cleaning nix-related system profiles..."
sudo rm -rf /etc/profile.d/nix.sh 2>/dev/null || true
sudo rm -rf /etc/zshrc.backup-before-nix-darwin 2>/dev/null || true

echo "==> Attempting to restore default shell environment..."

# Remove nix-darwin shell hooks if present
if grep -q "nix" /etc/zshrc 2>/dev/null; then
  sudo cp /etc/zshrc /etc/zshrc.nix-backup
  sudo sed -i '' '/nix/d' /etc/zshrc
fi

echo "==> Killing nix processes..."
sudo pkill nix-daemon || true

echo "==> Done."
echo ""
echo "IMPORTANT:"
echo "- Reboot your Mac now"
echo "- Check /etc/zshrc and clean manually if needed"
echo "- You may need to reinstall some CLI tools (git, etc.)"
