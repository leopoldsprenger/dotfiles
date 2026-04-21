return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "latexmk"

      -- IMPORTANT: use out_dir, not raw latexmk flags for state tracking
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
        options = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
        },
      }

      vim.g.vimtex_quickfix_mode = 0
    end,
  },
}
