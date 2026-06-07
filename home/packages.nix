{ pkgs, customPackages, ... }:

{
  home.packages =
    with pkgs; [
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
    ]
    ++ [
      customPackages.mousecape
    ];
}
