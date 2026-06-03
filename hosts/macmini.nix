{ ... }:

{
  networking.hostName = "macmini";

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "leopoldsprenger";
  };
}
