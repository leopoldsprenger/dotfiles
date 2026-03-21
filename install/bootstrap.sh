#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"

echo "=== Sanity checks ==="
if [ ! -d "$DOTFILES" ]; then
  echo "Dotfiles directory not found at $DOTFILES"
  exit 1
fi

mkdir -p "$BACKUP_DIR"

backup_if_exists() {
  local target="$1"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up existing $target"
    mv "$target" "$BACKUP_DIR/"
  fi
}

echo "=== Install Homebrew if missing ==="
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed"
fi

echo "=== Brew bundle install ==="
brew update
brew bundle --file "$DOTFILES/brew/Brewfile"

chmod +x brew-update.sh

echo "=== Install Oh My Zsh if missing ==="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh already installed"
fi

echo "=== Install Powerlevel10k if missing ==="
THEME_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$THEME_DIR" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEME_DIR"
else
  echo "Powerlevel10k already installed"
fi

echo "=== Install Mousecape if missing ==="

MOUSECAPE_APP="/Applications/Mousecape.app"
MOUSECAPE_ZIP="/Applications/Mousecape-Tahoe-PreRelease.zip"
MOUSECAPE_URL="https://github.com/AdamWawrzynkowskiGF/Mousecape-TahoeSupport/releases/download/PreRelease-v01/Mousecape-Tahoe-PreRelease.zip"

if [ ! -d "$MOUSECAPE_APP" ]; then
  echo "Mousecape not found. Installing..."

  sudo curl -L -o "$MOUSECAPE_ZIP" "$MOUSECAPE_URL"
  sudo unzip -o "$MOUSECAPE_ZIP" -d /Applications
  sudo rm -f "$MOUSECAPE_ZIP"

  echo "Removing quarantine attribute..."
  sudo xattr -dr com.apple.quarantine "$MOUSECAPE_APP"

  echo "Mousecape installed."
else
  echo "Mousecape already installed."

  echo "Ensuring quarantine attribute is removed..."
  sudo xattr -dr com.apple.quarantine "$MOUSECAPE_APP"
fi

echo "Importing cursor themes..."
open -a Mousecape "$DOTFILES/mousecape/vision.cursor.white.cape" \
  "$DOTFILES/mousecape/vision.cursor.black.cape"

# Open app so user can apply manually
open -a Mousecape

echo "=== Create required directories ==="
mkdir -p ~/.config
mkdir -p "$HOME/Library/Application Support/Code/User"
mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"

echo "=== Backup existing configs (once) ==="
backup_if_exists ~/.bash_profile
backup_if_exists ~/.bashrc
backup_if_exists ~/.zshrc
backup_if_exists ~/.zprofile
backup_if_exists ~/.gitconfig
backup_if_exists ~/.p10k.zsh

echo "=== Install Pico-8 if missing ==="

PICO8_APP="/Applications/PICO-8.app/Contents/MacOS"
PICO8_URL="https://www.lexaloffle.com/dl/7tiann/pico-8_0.2.5g_osx.zip"

if [ ! -d "$PICO8_APP" ]; then
  echo "Pico-8 not found. Installing..."
  
  tmp=$(mktemp -d)
  curl -L PICO8_URL -o "$tmp/app.zip"
  unzip -q "$tmp/app.zip" -d "$tmp"
  sudo mv "$tmp/pico-8/PICO-8.app" /Applications/
  rm -rf "$tmp"
else
  echo "Pico-8 already installed"
fi

echo "Installing Pico-8 CLI"
if ! command -v pico8 >/dev/null 2>&1; then
  WRAPPER_PATH="/opt/homebrew/bin/pico8"

  # Create wrapper with proper content using sudo and a here-document
  sudo tee "$WRAPPER_PATH" >/dev/null <<'EOF'
#!/usr/bin/env bash
# macOS PICO-8 CLI wrapper

PICO8_APP="/Applications/PICO-8.app/Contents/MacOS"

if [ ! -f "$PICO8_APP/pico8" ]; then
    echo "Error: PICO-8 binary not found at $PICO8_APP/pico8"
    exit 1
fi

exec "$PICO8_APP/pico8" -root_path "$PICO8_APP" "$@"
EOF

  # Make wrapper executable
  sudo chmod +x "$WRAPPER_PATH"

  # Verify
  echo "PICO-8 CLI wrapper installed at $WRAPPER_PATH"
else
  echo "Pico-8 CLI already set up"
fi

echo "=== Symlink dotfiles ==="

# Bash
ln -sf "$DOTFILES/bash/bash_profile" ~/.bash_profile
ln -sf "$DOTFILES/bash/bashrc" ~/.bashrc

# Zsh
ln -sf "$DOTFILES/zsh/zshrc" ~/.zshrc
ln -sf "$DOTFILES/zsh/zprofile" ~/.zprofile
ln -sf "$DOTFILES/ohmyposh" ~/.config/ohmyposh

# Git
ln -sf "$DOTFILES/git/gitconfig" ~/.gitconfig
ln -sf "$DOTFILES/git/gitignore_global" ~/.gitignore_global

# VS Code
ln -sf "$DOTFILES/vscode/settings.json" \
  "$HOME/Library/Application Support/Code/User/settings.json"
ln -sf "$DOTFILES/vscode/keybindings.json" \
  "$HOME/Library/Application Support/Code/User/keybindings.json"

# VS Code extensions
if [ -f "$DOTFILES/vscode/extensions.txt" ] && command -v code >/dev/null 2>&1; then
  echo "Installing VS Code extensions..."
  xargs -n 1 code --install-extension <"$DOTFILES/vscode/extensions.txt" || true
fi

# Make VS Code update script executable
chmod +x vscode-update.sh

# Neovim
ln -sf "$DOTFILES/nvim" ~/.config/nvim

# AerospaceWM
ln -sf "$DOTFILES/aerospace" ~/.config/aerospace

# SketchyBar
# install SbarLua first
git clone --depth 1 --quiet https://github.com/FelixKratz/SbarLua.git /tmp/sbarlua
cd /tmp/sbarlua && make install
# Symlink
ln -sf "$DOTFILES/sketchybar" ~/.config/sketchybar

# Janky Borders
ln -sf "$DOTFILES/janky-borders" ~/.config/borders

# Ghostty
ln -sf "$DOTFILES/ghostty/config" \
  "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

# Linearmouse
ln -sf "$DOTFILES/linearmouse/linearmouse.json" \
  "$HOME/.config/linearmouse/linearmouse.json"

# Raycast
if [ -f "$DOTFILES/raycast/backup.rayconfig" ]; then
  open $DOTFILES/raycast/backup.rayconfig
fi

echo "=== Enable background options and login items ==="
brew services start sketchybar
brew services start borders
osascript -e 'tell application "System Events" to make login item at end with properties {name:"AeroSpace", hidden:false}'

echo "=== Apply macOS defaults (UI tweaks) ==="
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0
killall Dock || true

echo "=== Bootstrap complete ==="
echo "Restart your terminal or run: source ~/.zshrc"
