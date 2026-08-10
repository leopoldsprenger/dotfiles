{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mkalias
  ];
}
