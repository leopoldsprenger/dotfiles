set -euo pipefail

mode="${1:-}"

dump() {
  brew list --formula > brew/formulae.txt
  brew list --cask > brew/casks.txt
  brew tap > brew/taps.txt

  brew bundle dump --file=brew/Brewfile --force
}

install() {
  brew bundle install --file=~/dotfiles/brew/Brewfile
}

case "$mode" in 
  dump)
    dump
    ;;
  install)
    install
    ;;
  *)
    echo "Invalid mode: $mode (expected 'dump' or 'install')" >&2
    exit 1
    ;;
esac
