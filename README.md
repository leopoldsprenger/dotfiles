# Dotfiles Bootstrap

This repository contains all of my versioned dotfiles and a bootstrap script to set up a macOS dev environment from scratch.

## Setup Instructions

1. Clone the repository into your home directory:
```bash
   git clone <your-repo-url> ~/dotfiles
```
2. Change into the dotfiles directory:
```bash
   cd ~/dotfiles
```
3. Make the bootstrap script executable:
```bash
   chmod +x bootstrap.sh
```
4. Run the bootstrap script:
```bash
   ./bootstrap.sh
```

> Note: I may beed to restart my PC for the config to take effect

## What the script does

The script will:

- Install Homebrew if it is not already installed.
- Install all Homebrew formulae and casks listed in the Brewfile.
- Install Oh My Zsh if it is missing.
- Create necessary directories for configs.
- Symlink all dotfiles to their appropriate locations:
  - Bash and Zsh configs, including P10k prompt.
  - Git config and global ignore.
  - VS Code settings, keybindings, and extensions.
  - Neovim configuration.
  - AerospaceWM configuration.
  - SketchyBar configuration.
  - Janky Borders configuration.
  - Ghostty configuration.
- Apply macOS defaults tweaks:
  - Hide the menu bar automatically.
  - Hide the Dock instantly with no animation.