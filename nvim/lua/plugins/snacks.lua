return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- Show hidden files by default
          ignored = false, -- Set to true if you also want to show git-ignored files
        },
      },
    },
  },
}
