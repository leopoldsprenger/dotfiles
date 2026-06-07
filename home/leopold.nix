{ ... }:

{
  imports = [
    ./packages.nix

    ./mousecape.nix
    ./supercmd.nix
    ./aerospace.nix
    ./git.nix
    ./ghostty.nix
    ./nvim.nix
    ./cursorcerer.nix
    ./linearmouse.nix
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
        ProgramArguments = [
          "/Applications/Zoom.app/Contents/MacOS/Zoom"
        ];
        RunAtLoad = true;
        KeepAlive = false;
        ProcessType = "Background";
      };
    };
  };
}
