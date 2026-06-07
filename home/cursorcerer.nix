{ config, pkgs, ... }:

{
  targets.darwin.currentHostDefaults."com.doomlaser.Cursorcerer" = {
    HideCursorOnLaunch = true;
    HideDelay = 5;
    HideOnType = true;
    HidePermanently = false;
  };
}
