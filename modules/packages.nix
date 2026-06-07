{ pkgs, customPackages, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    mkalias

    # core dev toolchain
    go
    lua
    nodejs

    cmake
    catch2_3

    # system-level CLI tools
    gh
  ]; 
}
