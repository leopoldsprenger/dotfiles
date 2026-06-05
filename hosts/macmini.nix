{ ... }:

{
  networking.hostName = "macmini";

  users.users.leopoldsprenger = {
    name = "leopoldsprenger";
    home = "/Users/leopoldsprenger";
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "leopoldsprenger";
  };

  homebrew = {
    enable = true;

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
