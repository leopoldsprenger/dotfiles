{ pkgs, customPackages, ... }:

{
  home.packages =
    with pkgs; [
      # Editor
      neovim

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

      # Prompt
      oh-my-posh
    ]
    ++ [
      customPackages.mousecape
    ];
}
