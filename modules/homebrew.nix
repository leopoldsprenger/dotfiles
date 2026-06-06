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
      "FelixKratz/formulae"     # sketchybar
      "nikitabobko/tap"         # aerospace
    ];

    brews = [
      "borders"
      "sketchybar"
    ];

    casks = [
      # dev + desktop managers
      "aerospace"
      "linearmouse"
      "cursorcerer"

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
