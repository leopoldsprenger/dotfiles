require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Terminal escape to normal mode" })

-- Typst preview
map("n", "<leader>pv", "<cmd>TypstPreview<CR>", { desc = "Typst preview" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
