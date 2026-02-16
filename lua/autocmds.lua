require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- Evento al cerrar buffers: si no quedan archivos, abre el Dash
autocmd("BufDelete", {
  callback = function()
    vim.schedule(function()
      local bufs = vim.fn.getbufinfo({buflisted = 1})
      if #bufs == 0 then
        local status, nvdash = pcall(require, "nvchad.nvdash")
        if status then
          nvdash.open()
        end
      end
    end)
  end,
})

autocmd("TermClose", {
  callback = function(ctx)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(ctx.buf) then
        -- Borramos el buffer a la fuerza (!)
        vim.api.nvim_buf_delete(ctx.buf, { force = true })
        -- Si quedó una ventana vacía a la derecha, la cerramos
        vim.cmd "silent! close"
      end
    end)
  end,
})

-- Al entrar a cualquier ventana de terminal, activar modo insertar automáticamente
autocmd({"WinEnter", "BufWinEnter"}, {
  pattern = "term://*",
  callback = function()
    vim.cmd "startinsert"
    vim.opt_local.cursorline = true
  end,
})

autocmd("VimLeavePre", {
  callback = function()
    require("persistence").save()
  end,
})

autocmd("WinLeave", {
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
