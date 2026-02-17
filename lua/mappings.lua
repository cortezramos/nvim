require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--

map("n", "<F12>", function()
  local word = vim.fn.expand "<cword>"
  require("telescope.builtin").live_grep { default_text = word }
end, { desc = "Buscar implementación por texto" })

-- En tu archivo de mappings
map("n", "<leader>da", "<cmd> Nvdash <cr>", { desc = "Ir al Dashboard" })

map("n", "<leader>x", function()
  local bufs = vim.fn.getbufinfo { buflisted = 1 }

  if #bufs <= 1 then
    -- Si es el último buffer, abrimos el Dash ANTES de borrar el buffer
    local status, nvdash = pcall(require, "nvchad.nvdash")
    if status then
      nvdash.open()
      -- Borramos el buffer anterior en segundo plano para que no se cierre la app
      vim.cmd "bwipeout #"
    end
  else
    -- Si hay más buffers, usamos el cierre normal de NvChad
    require("nvchad.tabufline").close_buffer()
  end
end, { desc = "Cerrar buffer y volver al Dash si es el último" })

map("n", "<leader>da", function()
  require("nvchad.nvdash").open()
end, { desc = "Abrir Dashboard DEV" })

-- Abrir el Dashboard en cualquier momento
map("n", "<leader>da", function()
  local status, nvdash = pcall(require, "nvchad.nvdash")
  if status then
    nvdash.open()
  end
end, { desc = "Abrir Dashboard Solidarity" })

_G.toggle_AI_term = function()
  -- Usamos la API de bajo nivel para saltarnos el problema del 'cmd' string
  local api = vim.api

  if vim.bo.filetype == "nvdash" then
    -- Intentamos saltar al buffer anterior (el último archivo real abierto)
    api.nvim_command "silent! b# "

    -- Si después de b# seguimos en un buffer vacío o dashboard,
    -- significa que no había archivos abiertos.
    if vim.bo.filetype == "nvdash" or vim.bo.buftype == "nofile" then
      api.nvim_command "enew"
    end
  end

  api.nvim_command "vsplit"
  api.nvim_command "wincmd l"
  api.nvim_command "terminal"

  local width = math.floor(vim.o.columns * 0.4)
  api.nvim_win_set_width(0, width)

  vim.opt_local.buflisted = false

  api.nvim_command "startinsert"
end

-- NAVEGACIÓN DESDE MODO NORMAL (Cuando estás en el código)
map("n", "<C-h>", "<C-w>h", { desc = "Ventana Izquierda" })
map("n", "<C-l>", "<C-w>l", { desc = "Ventana Derecha" })

-- NAVEGACIÓN DESDE MODO TERMINAL (Cuando estás escribiendo en la terminal)
-- Esto es lo que te permite "escapar" automáticamente
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Saltar al Código (Izquierda)" })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Saltar a la Terminal (Derecha)" })

-- Si quieres seguir usando Alt/Opt pero sin que abra la terminal de NvChad:
map({ "n", "t" }, "<A-h>", [[<C-\><C-n><C-w>h]], { desc = "Navegar Izquierda" })
map({ "n", "t" }, "<A-l>", [[<C-\><C-n><C-w>l]], { desc = "Navegar Derecha" })

local map = vim.keymap.set

-- Restaurar la sesión del directorio actual
map("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = "Restaurar sesión" })

-- Restaurar la ÚLTIMA sesión global (la última que cerraste)
map("n", "<leader>ql", function()
  require("persistence").load { last = true }
end, { desc = "Restaurar última sesión" })

-- Formateo de código con Conform
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true, async = false, timeout_ms = 500 }
end, { desc = "Formatear archivo (Estilo Gentleman)" })

map("n", "<leader>oi", function()
  require("jdtls").organize_imports()
end, { desc = "Organizar e importar" })

map("v", "<Tab>", ">gv", { desc = "Tabular a la derecha" })
map("v", "<S-Tab>", "<gv", { desc = "Tabular a la izquierda" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover bloque abajo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover bloque arriba" })
