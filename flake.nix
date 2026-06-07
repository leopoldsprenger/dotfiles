{
  description = "Leopold's nix-darwin configuration";

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

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    nix-homebrew,
    home-manager,
    ...
  }: 
  let
    system = "aarch64-darwin";
    pkgs = import nixpkgs { inherit system; };
    customPackages = import ./packages { inherit pkgs; };
  in {
    packages.${system} = {
      mousecape = pkgs.callPackage ./packages/mousecape.nix { };
    };

    darwinConfigurations.macmini =
      nix-darwin.lib.darwinSystem {
        inherit system;

        modules = [
          { _module.args = { inherit self customPackages; }; }

          ./modules/system.nix
          ./modules/packages.nix
          ./modules/fonts.nix
          ./modules/homebrew.nix
          ./modules/defaults.nix

          ./hosts/macmini.nix

          nix-homebrew.darwinModules.nix-homebrew

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = { inherit self customPackages; };

            home-manager.users.leopoldsprenger.imports = [
              ./home/leopold.nix
            ];
          }
        ];
      };

    darwinConfigurations.macbook =
      nix-darwin.lib.darwinSystem {
        inherit system;

        modules = [
          { _module.args = { inherit self customPackages; }; }

          ./modules/system.nix
          ./modules/packages.nix
          ./modules/fonts.nix
          ./modules/homebrew.nix
          ./modules/defaults.nix

          ./hosts/macbook.nix

          nix-homebrew.darwinModules.nix-homebrew

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = { inherit self customPackages; };

            home-manager.users.leopoldsprenger.imports = [
              ./home/leopold.nix
            ];
          }
        ];
      };
  };
}
