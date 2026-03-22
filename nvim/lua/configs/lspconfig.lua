
require("nvchad.configs.lspconfig").defaults()

local servers = { "lua_ls", "html", "cssls", "ts_ls", "gopls", "basedpyright", "ruff", "clangd", "tinymist" }
vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({
            bufnr = args.buf,
            id = client.id,
            filter = function(c) return c.name ~= "basedpyright" end
          })
        end,
      })
    end
  end,
})

