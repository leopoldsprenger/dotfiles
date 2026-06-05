{ ... }:

{
  networking.hostName = "macmini";

  users.users.leopoldsprenger = {
    name = "leopoldsprenger";
    home = "/Users/leopoldsprenger";
  };

  nix-homebrew = {
    enable = false; # change this later
    enableRosetta = true;
    user = "leopoldsprenger";
    mutableTaps = false;
  };

  homebrew = {
    enable = false; # change this later too

    brews = [
      "mas"
    ];

    casks = [ ];
    masApps = { };

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
