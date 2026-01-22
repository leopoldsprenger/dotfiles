-- require mason packages

require("mason").setup()

require("mason-tool-installer").setup({
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

    -- Treesitter
    "tree-sitter-cli",
  },

  -- optional but recommended
  auto_update = false,
  run_on_start = true,
})
