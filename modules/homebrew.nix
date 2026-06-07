{ ... }:

{
  nix-homebrew = {
    enable = false; # change this later
    user = "leopoldsprenger";
    mutableTaps = false;
  };

  homebrew = {
    enable = false; # change this later

    taps = [

    ];

    brews = [
    
    ];

    casks = [
      # dev + desktop managers
      "linearmouse"
      "cursorcerer"
      "supercmdlabs/supercmd/supercmd"
      "ghostty"

      # browsers + core apps
      "zen"
      "obsidian"
      "logseq"
      "notion"

      # communication
      "signal"
      "whatsapp"
      "zoom"

      # password / auth
      "bitwarden"

      # mac workflow
      "mactex-no-gui"
    ];

    masApps = {
      "AdBlock for Safari" = 1018301726;
      "Focus for YouTube"  = 1514703160;

      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages"   = 409201541;

      "Pure Paste" = 1611378436;
      "Things 3"   = 904280696;
    };

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
