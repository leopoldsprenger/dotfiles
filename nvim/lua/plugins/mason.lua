return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- Python
        "basedpyright",
        "black",
        "isort",
        "ruff",

        -- C / C++
        "clangd",
        "clang-format",

        -- Lua
        "lua-language-server",
        "stylua",

        -- Shell
        "shfmt",

        -- Go
        "gopls",
        "golangci-lint",
        "staticcheck",
        "gofumpt",
        "goimports",
        "delve",

        -- Treesitter tooling
        "tree-sitter-cli",
      },
      run_on_start = true,
      auto_update = false,
    },
  },
}

