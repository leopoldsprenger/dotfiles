return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "basedpyright",
        "black",
        "isort",
        "ruff",
        "clangd",
        "clang-format",
        "lua-language-server",
        "stylua",
        "shfmt",
        "tree-sitter-cli",
      },
      run_on_start = true,
      auto_update = false,
    },
  },
}
