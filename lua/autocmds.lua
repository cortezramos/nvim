require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- Evento al cerrar buffers: si no quedan archivos, abre el Dash
autocmd("BufDelete", {
  callback = function()
    vim.schedule(function()
      local bufs = vim.fn.getbufinfo { buflisted = 1 }
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
autocmd({ "WinEnter", "BufWinEnter" }, {
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

autocmd("BufNewFile", {
  pattern = "*.java",
  callback = function()
    local name = vim.fn.expand "%:t:r"
    local path = vim.fn.expand "%:p:h"
    local package = path:match "src/[^/]+/java/(.+)$"

    local lines = {}
    if package then
      package = package:gsub("/", ".")
      table.insert(lines, "package " .. package .. ";")
      table.insert(lines, "")
    end

    table.insert(lines, "public class " .. name .. " {")
    table.insert(lines, "")
    table.insert(lines, "}")

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

    -- SOLUCIÓN AL ERROR: Verificar cuántas líneas tenemos antes de mover el cursor
    local line_count = vim.api.nvim_buf_line_count(0)
    local target_line = package and 4 or 2 -- Si hay package, línea 4; si no, línea 2

    if line_count >= target_line then
      vim.api.nvim_win_set_cursor(0, { target_line, 0 })
    end
  end,
})

autocmd("BufNewFile", {
  pattern = "*.vue",
  callback = function()
    local template = {
      '<script setup lang="ts">',
      "// " .. vim.fn.expand "%:t" .. " logic",
      "</script>",
      "",
      "<template>",
      '  <div class="' .. vim.fn.expand("%:t:r"):lower() .. '-container">',
      "    ",
      "  </div>",
      "</template>",
      "",
      "<style scoped>",
      "",
      "</style>",
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
    local target_vue = 7 -- Línea dentro del <div>
    if vim.api.nvim_buf_line_count(0) >= target_vue then
      vim.api.nvim_win_set_cursor(0, { target_vue, 4 })
    end
  end,
})
