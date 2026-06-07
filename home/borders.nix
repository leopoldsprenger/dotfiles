{ config, pkgs, ... }:

{
  services.jankyborders = {
    enable = true;
    package = pkgs.jankyborders;

    settings = {
      style = "round";
      width = "2.0";
      hidpi = "off";
      active_color = "0xff7aa2f7";
      inactive_color = "0xff2a2e38";
    };
  };
}
