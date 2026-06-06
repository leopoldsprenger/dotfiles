{ ... }:

{
  networking.hostName = "macbook";

  users.users.leopoldsprenger = {
    name = "leopoldsprenger";
    home = "/Users/leopoldsprenger";
  };

  # enable tap to click
  system.defaults.trackpad.Clicking = true;
}

