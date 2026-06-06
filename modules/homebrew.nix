{ ... }:

{
  nix-homebrew = {
    enable = false; # change this later
    user = "leopoldsprenger";
    mutableTaps = false;
  };

  homebrew = {
    enable = false; # change this later

    brews = [
      "mas"
    ];

    casks = [

    ];

    masApps = {

    };

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
