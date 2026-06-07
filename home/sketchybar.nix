{ config, pkgs, ... }:

{
  programs.sketchybar = {
    enable = true;
    package = pkgs.sketchybar;
    configType = "bash";
  };

  xdg.configFile."sketchybar" = {
    source = ../resources/sketchybar;
    recursive = true;
    force = true;
  };
}
