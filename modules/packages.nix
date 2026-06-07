{ pkgs, customPackages, ... }:

{
  environment.systemPackages = with pkgs; [
    mkalias
  ]; 
}
