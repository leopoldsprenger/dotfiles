{ config, pkgs, lib, ... }: {

  programs.aerospace = {
    enable = true;
    package = pkgs.aerospace;
    launchd.enable = true;

    settings = pkgs.lib.importTOML ../resources/aerospace/aerospace.toml;
  };

  xdg.configFile."aerospace/aerospace.toml".source = 
    lib.mkForce config.home.file.".aerospace.toml".source;

  home.file.".aerospace.toml".enable = false;
}
