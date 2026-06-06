{ pkgs, config, self, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.primaryUser = "leopoldsprenger";

  environment.systemPackages = with pkgs; [
    # alias nix apps to /Applications/ for spotlight indexing
    mkalias
    # set desktop wallpaper and finder favorites
    desktoppr
    mysides
  ];

  fonts.packages = [ ];

  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.configurationRevision =
    self.rev or self.dirtyRev or null;

  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = [ "/Applications" ];
      };
    in
    pkgs.lib.mkForce ''
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps

      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';
}
