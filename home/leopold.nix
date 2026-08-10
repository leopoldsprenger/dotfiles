{ ... }:

{
  imports = [
    ./packages.nix

    ./mousecape.nix
    ./raycast.nix
    ./aerospace.nix
    ./git.nix
    ./ghostty.nix
    ./nvim.nix
    ./cursorcerer.nix
    ./linearmouse.nix
    ./borders.nix
    ./sketchybar.nix

    # fixed: these two existed on disk but were never imported, so neither
    # program.zsh nor oh-my-posh was actually applied by home-manager.
    ./zsh.nix
    ./ohmyposh.nix
  ];

  home.stateVersion = "24.11";

  home.username = "leopoldsprenger";
  home.homeDirectory = "/Users/leopoldsprenger";

  programs.home-manager.enable = true;

  launchd.agents = {
    things-autostart = {
      enable = true;
      config = {
        ProgramArguments = [
          "/Applications/Things3.app/Contents/MacOS/Things3"
        ];
        RunAtLoad = true;
        ProcessType = "Interactive";
      };
    };

    zoom-updater-autostart = {
      enable = true;
      config = {
        # fixed: the zoom cask installs "zoom.us.app", not "Zoom.app" — the
        # old path pointed at a binary that never existed, so this agent
        # would just fail silently at every login.
        ProgramArguments = [
          "/Applications/zoom.us.app/Contents/MacOS/zoom.us"
        ];
        RunAtLoad = true;
        KeepAlive = false;
        ProcessType = "Background";
      };
    };
  };
}
