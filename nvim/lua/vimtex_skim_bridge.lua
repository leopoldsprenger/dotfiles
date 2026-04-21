      local M = {}

      -- returns the compiled pdf path (vimtex gives basename in b:vimtex.out())
      local function pdf_path()
        -- b:vimtex.out() returns the output filename (pdf basename).
        local out = vim.b.vimtex and vim.b.vimtex.out and vim.b.vimtex.out() or nil
        if not out then return nil end
        -- If latexmk used build_dir, the pdf is in 'build/<out>'
        return vim.fn.fnamemodify(vim.fn.getcwd(), ':p') .. "build/" .. out
      end

      function M.update_skim()
        local pdf = pdf_path()
        if not pdf then return end
        local src = vim.fn.expand("%:p")
        local line = tostring(vim.fn.line('.'))
        -- Build args: displayline <line> <pdf> <src> [-g]
        local cmd = { "/Applications/Skim.app/Contents/SharedSupport/displayline", line, pdf, src }
        -- add -g if Skim already running (makes it bring the doc to front)
        if vim.fn.empty(vim.fn.system("pgrep Skim")) == 0 then
          table.insert(cmd, "-g")
        end
        -- Start job (non-blocking)
        vim.fn.jobstart(cmd, { detach = true })
      end

      return M
      