return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Plugin to display custom ascii art in NvDash 
  {
    "MaximilianLloyd/ascii.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },

  {
    'wakatime/vim-wakatime', 
    lazy = false,
  },

  {
    "williamboman/mason.nvim",
    lazy = false,
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

        -- Typst
        "tinymist",
      },
      automatic_installation = true,
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = function()
      local treesitter_langs = { "vim", "lua", "vimdoc", "html", "css", "javascript", "go", "python", "cpp", "typst" }
      local lang_to_lsp = {
        lua = "lua_ls",
        html = "html",
        css = "cssls",
        javascript = "ts_ls",
        go = "gopls",
        python = "basedpyright",
        cpp = "clangd",
        typst = "tinymist",
      }
      local ensure_installed = {}
      for _, lang in ipairs(treesitter_langs) do
        if lang_to_lsp[lang] then
          table.insert(ensure_installed, lang_to_lsp[lang])
        end
      end
      return { ensure_installed = ensure_installed }
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css", "javascript",
       "go", "python", "cpp",
       "typst"
  		},
      highlight = { enable = true },
  	},
  },

  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {},
  },
}
