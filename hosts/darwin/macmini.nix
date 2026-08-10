{ pkgs, ... }:

{
  networking.hostName = "macmini";

  users.users.leopoldsprenger = {
    name = "leopoldsprenger";
    home = "/Users/leopoldsprenger";
  };
}
