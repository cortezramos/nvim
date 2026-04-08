require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

local nvim_config = vim.fn.stdpath "config"

-- Función para limpiar un buffer de vim.t.bufs
local function remove_from_tabufline(bufnr)
  local bufs = vim.t.bufs or {}
  for i, nr in ipairs(bufs) do
    if nr == bufnr then
      table.remove(bufs, i)
      vim.t.bufs = bufs
      return
    end
  end
end

-- Oil: marcar buffer como no listado
autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.bo.buflisted = false
  end,
})

-- Ocultar de tabufline archivos internos de nvim (ftplugin, configs)
-- Solo aplica a archivos lua cargados como parte del runtime de nvim,
-- NO a archivos que el usuario abre intencionalmente con :e o desde oil
autocmd("BufAdd", {
  callback = function(ev)
    local name = vim.api.nvim_buf_get_name(ev.buf)
    -- Solo excluir si viene del config de nvim Y no fue abierto por el usuario
    -- (los archivos abiertos por el usuario tienen ventana asociada)
    if name:find(nvim_config, 1, true) then
      local wins = vim.fn.win_findbuf(ev.buf)
      if #wins == 0 then
        vim.bo[ev.buf].buflisted = false
        remove_from_tabufline(ev.buf)
      end
    end
  end,
})

-- (oil maneja la navegación, no hace falta abrir nada automáticamente al borrar buffers)
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

local function java_snippet()
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

  local line_count = vim.api.nvim_buf_line_count(0)
  local target_line = package and 4 or 2 -- Si hay package, línea 4; si no, línea 2

  if line_count >= target_line then
    vim.api.nvim_win_set_cursor(0, { target_line, 0 })
  end
end

autocmd("BufNewFile", {
  pattern = "*.java",
  callback = java_snippet,
})

vim.keymap.set("n", "<leader>sj", java_snippet, { noremap = true, silent = true, desc = "Snippet Java" })

local function vue_snippet()
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
end

autocmd("BufNewFile", {
  pattern = "*.vue",
  callback = vue_snippet,
})

vim.keymap.set("n", "<leader>sv", vue_snippet, { noremap = true, silent = true, desc = "Snippet Vue" })
