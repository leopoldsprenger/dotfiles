set -euo pipefail

mode="${1:-}"

install_extensions() {
  xargs -n 1 code --install-extension < vscode/extensions.txt
}

update_dotfiles() {
  code --list-extensions > vscode/extensions.txt
}

case "$mode" in
  install-extensions)
    install_extensions
    ;;
  update-dotfiles)
    update_dotfiles
    ;;
  *)
    echo "Invalid mode: $mode (expected 'install-extensions' or 'update-dotfiles')" >&2
    exit 1
    ;;
esac
