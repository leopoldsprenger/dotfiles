# modules/mousecape.nix
{ config, pkgs, ... }:

let
  mousecape-tahoe = pkgs.stdenv.mkDerivation rec {
    pname = "mousecape";
    version = "Tahoe-PreRelease";

    src = pkgs.fetchurl {
      url = "https://github.com";
      hash = ""; 
    };

    nativeBuildInputs = [ pkgs.unzip ];

    unpackPhase = "unzip $src";

    installPhase = ''
      mkdir -p $out/Applications
      cp -R Mousecape.app $out/Applications/
    '';

    postFixup = ''
      /usr/bin/xattr -dr com.apple.quarantine $out/Applications/Mousecape.app || true
    '';
  };
in
{
  environment.systemPackages = [ mousecape-tahoe ];

  system.activationScripts.postUserActivation.text = ''
    ln -sfn "${mousecape-tahoe}/Applications/Mousecape.app" "/Applications/Mousecape.app"

    DOTFILES_DIR="$HOME/dotfiles"

    if [ -d "$DOTFILES_DIR/mousecape" ]; then
      /usr/bin/open -g -a Mousecape \
        "$DOTFILES_DIR/mousecape/vision.cursor.white.cape" \
        "$DOTFILES_DIR/mousecape/vision.cursor.black.cape"

      sleep 2

      /usr/bin/osascript -e 'quit app "Mousecape"'
    fi
  '';
}
