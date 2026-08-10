{ config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    withPython3 = false;
    withRuby = false;
  };

  xdg.configFile."nvim" = {
    source = ../resources/nvim;
    force = true;
  };
}
