{ ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    configFile = ../resources/ohmyposh/ohmyposh.toml;
  };
}
