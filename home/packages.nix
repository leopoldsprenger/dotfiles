{ pkgs, customPackages, ... }:

{
  home.packages =
    with pkgs; [
      git
      gh

      # CLI utilities
      ripgrep
      fd
      fzf
      tree
      zoxide

      # Development
      ruff
      uv
      typst
      go
      lua
      nodejs
    ] ++ [
      customPackages.mousecape
    ];
}
