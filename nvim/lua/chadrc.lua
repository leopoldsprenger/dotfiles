
local M = {}

M.base46 = {
  theme = "catppuccin",
}

M.nvdash = {
  load_on_startup = true,
  header = (function()
    local ascii = require("ascii")
    return ascii.art.misc.hydra.hydra
  end)(),
}

-- Automatically cd into the directory if nvim is started with a path
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local args = vim.fn.argv()
    if #args > 0 then
      local path = tostring(args[1])
      if vim.fn.isdirectory(path) == 1 then
        vim.api.nvim_set_current_dir(path)
      end
    end
  end,
})

return M

