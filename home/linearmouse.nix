{ config, pkgs, ... }:

{
  xdg.configFile."linearmouse/linearmouse.json" = {
    source = ../resources/linearmouse/linearmouse.json;
    force = true; 
  };
}
