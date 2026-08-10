{
  description = "Leopold's Nix configuration — nix-darwin machines today, room for NixOS hosts alongside";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, nix-darwin, nix-homebrew, home-manager, sops-nix, ... }:
    let
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Local packages (e.g. mousecape) available both as flake outputs and
      # threaded into home-manager/darwin modules via specialArgs.
      customPackages = import ./packages { inherit pkgs; };

      # All the shared darwinSystem plumbing lives in lib/mkdarwin.nix, so a
      # new machine is just one line below plus a hosts/darwin/<name>.nix.
      mkDarwin = import ./lib/mkdarwin.nix {
        inherit
          nix-darwin
          nix-homebrew
          home-manager
          sops-nix
          self
          pkgs
          customPackages
          system
          ;
      };
    in
    {
      # `nix build .#mousecape`, etc.
      packages.${system} = customPackages;

      darwinConfigurations = {
        macmini = mkDarwin "macmini";
        macbook = mkDarwin "macbook";
      };

      # A NixOS box can slot in alongside the darwin machines without
      # restructuring anything above:
      #
      #   1. add modules under ./modules/nixos/
      #   2. add a ./hosts/nixos/<hostname>.nix (+ its hardware-configuration.nix)
      #   3. write ./lib/mknixos.nix, mirroring lib/mkdarwin.nix but calling
      #      nixpkgs.lib.nixosSystem instead of nix-darwin.lib.darwinSystem
      #   4. nixosConfigurations.<hostname> = mkNixos "<hostname>";
      #
      # See modules/nixos/README.md and hosts/nixos/README.md.
    };
}
