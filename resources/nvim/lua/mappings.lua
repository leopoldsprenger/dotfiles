require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Terminal escape to normal mode" })

-- Typst preview
map("n", "<leader>pv", "<cmd>TypstPreview<CR>", { desc = "Typst preview" })

-- Latex shortcuts
map("n", "<leader>ll", "<cmd>VimtexCompile<CR>", { desc = "Compile latex" })
map("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "View latex" })
map("n", "<leader>lk", "<cmd>VimtexStop<CR>", { desc = "Stop vimtex/latex" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
