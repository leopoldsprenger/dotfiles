#!/usr/bin/env bash
set -euo pipefail

DOTFILES=~/dotfiles

echo "=== Install Homebrew if missing ==="
if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed"
fi

echo "=== Brew bundle install ==="
brew update
brew tap homebrew/bundle
brew bundle --file "$DOTFILES/brew/Brewfile"

echo "=== Install Oh My Zsh if missing ==="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed"
fi

echo "=== Create necessary directories ==="
mkdir -p ~/.config
mkdir -p ~/Library/Application\ Support/Code/User
mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty

echo "=== Symlink dotfiles ==="

# Bash
ln -sf "$DOTFILES/bash/bash_profile" ~/.bash_profile
ln -sf "$DOTFILES/bash/bashrc"       ~/.bashrc

# Zsh + P10k
ln -sf "$DOTFILES/zsh/zshrc"    ~/.zshrc
ln -sf "$DOTFILES/zsh/zprofile" ~/.zprofile
ln -sf "$DOTFILES/p10k/p10k.zsh" ~/.p10k.zsh

# Git
ln -sf "$DOTFILES/git/gitconfig"         ~/.gitconfig
ln -sf "$DOTFILES/git/gitignore_global"  ~/.gitignore_global

# VS Code settings and keybindings
ln -sf "$DOTFILES/vscode/settings.json"    ~/Library/Application\ Support/Code/User/settings.json
ln -sf "$DOTFILES/vscode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json

# VS Code extensions
if [ -f "$DOTFILES/vscode/extensions.txt" ]; then
    echo "Installing VS Code extensions..."
    cat "$DOTFILES/vscode/extensions.txt" | xargs -n 1 code --install-extension || true
fi

# Neovim
ln -sf "$DOTFILES/nvim" ~/.config/nvim

# AerospaceWM
ln -sf "$DOTFILES/aerospace" ~/.config/aerospace

# SketchyBar
ln -sf "$DOTFILES/sketchybar" ~/.config/sketchybar

# Janky Borders
ln -sf "$DOTFILES/janky-borders" ~/.config/borders

# Ghostty
ln -sf "$DOTFILES/ghostty/config" ~/Library/Application\ Support/com.mitchellh.ghostty/config

#!/usr/bin/env bash
set -euo pipefail

DOTFILES=~/dotfiles

echo "=== Install Homebrew if missing ==="
if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed"
fi

echo "=== Brew bundle install ==="
brew update
brew tap homebrew/bundle
brew bundle --file "$DOTFILES/brew/Brewfile"

echo "=== Install Oh My Zsh if missing ==="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed"
fi

echo "=== Create necessary directories ==="
mkdir -p ~/.config
mkdir -p ~/Library/Application\ Support/Code/User
mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty

echo "=== Symlink dotfiles ==="

# Bash
ln -sf "$DOTFILES/bash/bash_profile" ~/.bash_profile
ln -sf "$DOTFILES/bash/bashrc"       ~/.bashrc

# Zsh + P10k
ln -sf "$DOTFILES/zsh/zshrc"    ~/.zshrc
ln -sf "$DOTFILES/zsh/zprofile" ~/.zprofile
ln -sf "$DOTFILES/p10k/p10k.zsh" ~/.p10k.zsh

# Git
ln -sf "$DOTFILES/git/gitconfig"         ~/.gitconfig
ln -sf "$DOTFILES/git/gitignore_global"  ~/.gitignore_global

# VS Code settings and keybindings
ln -sf "$DOTFILES/vscode/settings.json"    ~/Library/Application\ Support/Code/User/settings.json
ln -sf "$DOTFILES/vscode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json

# VS Code extensions
if [ -f "$DOTFILES/vscode/extensions.txt" ]; then
    echo "Installing VS Code extensions..."
    cat "$DOTFILES/vscode/extensions.txt" | xargs -n 1 code --install-extension || true
fi

# Neovim
ln -sf "$DOTFILES/nvim" ~/.config/nvim

# AerospaceWM
ln -sf "$DOTFILES/aerospace" ~/.config/aerospace

# SketchyBar
ln -sf "$DOTFILES/sketchybar" ~/.config/sketchybar

# Janky Borders
ln -sf "$DOTFILES/janky-borders" ~/.config/borders

# Ghostty
ln -sf "$DOTFILES/ghostty/config" ~/Library/Application\ Support/com.mitchellh.ghostty/config

echo "=== Applying macOS defaults tweaks ==="

# 1. Hide menu bar (status bar)
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# 2. Hide Dock instantly with no animation
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0
killall Dock

echo "=== Bootstrap complete! ==="
echo "You may need to restart your shell or run 'source ~/.zshrc' to apply changes."