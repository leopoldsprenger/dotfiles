{ pkgs, ... }: 

{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = pkgs.lib.importTOML ../resources/ohmyposh/ohmyposh.toml;
  };
}
