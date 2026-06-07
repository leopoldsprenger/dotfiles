{ config, ... }: 

{
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  home.file.".zshrc" = {
    source = ../resources/zsh/zshrc;
    force = true; 
  };
}
