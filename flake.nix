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
    nix-darwin,
    nix-homebrew,
    home-manager,
    ...
  }: {

    darwinConfigurations.macmini =
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          { _module.args = { inherit self; }; }

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

            home-manager.users.leopoldsprenger.imports = [
              ./home/leopold.nix
            ];
          }
        ];
      };

    darwinConfigurations.macbook =
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          { _module.args = { inherit self; }; }

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

            home-manager.users.leopoldsprenger.imports = [
              ./home/leopold.nix
            ];
          }
        ];
      };
  };
}
