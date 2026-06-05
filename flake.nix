{
  description = "Leopold's Mac nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, nix-homebrew, home-manager, ... }:
  let
    systemConfig = import ./modules/system.nix;
  in
  {
    darwinConfigurations.macmini = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      modules = [
        { _module.args = { inherit self; }; }

        systemConfig
        ./hosts/macmini.nix

        nix-homebrew.darwinModules.nix-homebrew

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.leopoldsprenger = {
            imports = [ ./home/leopold.nix ];
          };
        }
      ];
    };
  };
}
