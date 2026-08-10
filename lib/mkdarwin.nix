# Builds one darwinConfiguration. All the plumbing that used to be copy-pasted
# between macmini and macbook in flake.nix (module list, home-manager wiring,
# specialArgs) lives here exactly once. A host file only has to describe what
# is actually different about that machine — see hosts/darwin/*.nix.
{
  nix-darwin,
  nix-homebrew,
  home-manager,
  sops-nix,
  self,
  pkgs,
  customPackages,
  system,
}:

hostname:

nix-darwin.lib.darwinSystem {
  inherit system;

  specialArgs = { inherit self customPackages; };

  modules = [
    ../modules/darwin/system.nix
    ../modules/darwin/packages.nix
    ../modules/darwin/fonts.nix
    ../modules/darwin/homebrew.nix
    ../modules/darwin/defaults.nix
    ../modules/darwin/secrets.nix
    ../modules/darwin/mail.nix

    ../hosts/darwin/${hostname}.nix

    nix-homebrew.darwinModules.nix-homebrew
    sops-nix.darwinModules.sops

    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      home-manager.backupFileExtension = "backup";

      home-manager.extraSpecialArgs = { inherit self customPackages; };

      home-manager.users.leopoldsprenger.imports = [
        ../home/leopold.nix
      ];
    }
  ];
}
