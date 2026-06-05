{ pkgs, ... }:

{
  home.stateVersion = "24.11";

  home.username = "leopoldsprenger";
  home.homeDirectory = "/Users/leopoldsprenger";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [];
}
