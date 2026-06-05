{ ... }:

{
  networking.hostName = "macmini";

  system.primaryUser = "leopoldsprenger";

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "leopoldsprenger";
  };
}
