{ pkgs, ... }:

{
  home.stateVersion = "24.11";

  home.username = "leopoldsprenger";
  home.homeDirectory = "/Users/leopoldsprenger";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neovim

    ripgrep
    fd
    fzf
    tree
    zoxide

    ruff
    uv
    typst
  ];

  launchd.agents = {
    things-autostart = {
      enable = true;
      config = {
        ProgramArguments = [ "/Applications/Things3.app/Contents/MacOS/Things3" ];
        RunAtLoad = true;
        ProcessType = "Interactive";
      };
    };

    zoom-updater-autostart = {
      enable = true;
      config = {
        ProgramArguments = [ "/Applications/Zoom.app/Contents/MacOS/Zoom" ];
        RunAtLoad = true;
        KeepAlive = false;
        ProcessType = "Background";
      };
    };
  };
}

