require("nvchad.configs.lspconfig").defaults()

local servers = { "lua_ls", "html", "cssls", "ts_ls", "gopls", "basedpyright", "clangd", "tinymist" }
vim.lsp.enable(servers)
