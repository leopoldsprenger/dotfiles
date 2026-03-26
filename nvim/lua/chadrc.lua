local M = {}

local bg_main = "#222436"
local bg_darker = "#1e2030"

M.base46 = {
  theme = "tokyonight",
  hl_override = {
    Normal = { bg = bg_main },
    NvimTreeNormal = { bg = bg_darker },
    NvimTreeNormalNC = { bg = bg_darker },
    TelescopeNormal = { bg = bg_darker },
    TelescopeBorder = { bg = bg_darker, fg = bg_darker },
    TelescopePromptNormal = { bg = bg_darker },
    TelescopePromptBorder = { bg = bg_darker, fg = bg_darker },
    NormalFloat = { bg = bg_darker },
    FloatBorder = { bg = bg_darker, fg = bg_darker },
    NvdashBg = { bg = bg_main },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = (function()
    local ascii = require "ascii"
    return ascii.art.text.neovim.ansi_shadow
  end)(),
}

vim.o.relativenumber = true

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
