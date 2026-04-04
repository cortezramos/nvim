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
    local status, nt_api = pcall(require, "nvim-tree.api")
    if status then
      nt_api.tree.open()
      -- Borramos el buffer anterior en segundo plano para que no se cierre la app
      vim.cmd "bwipeout #"
    else
      vim.cmd "bwipeout"
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
end, { desc = "Formatear archivo" })

map("n", "<leader>oi", function()
  require("jdtls").organize_imports()
end, { desc = "Organizar e importar" })

map("v", "<Tab>", ">gv", { desc = "Tabular a la derecha" })
map("v", "<S-Tab>", "<gv", { desc = "Tabular a la izquierda" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover bloque abajo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover bloque arriba" })

local map = vim.keymap.set

-- Code Actions (Importaciones, implementar interfaces, etc.)
vim.keymap.set("n", "<M-p>", vim.lsp.buf.code_action, { desc = "LSP Code Action (IntelliJ style)" })
-- Poner punto de quiebre (Toggle Breakpoint)
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "Poner punto de quiebre" })
-- Abrir la interfaz de variables
map("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "Ver variables" })
-- 3. Los "pasos" de debug (como en IntelliJ)
map("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", { desc = "Debugger: Continuar/Ejecutar" })
map("n", "<F8>", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Debugger: Siguiente línea" })
map("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Debugger: Entrar a función" })

map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { desc = "Renombrar símbolo" })

-- Navegar en ocurrencias con Illuminate
vim.keymap.set("n", "]]", function()
  require("illuminate").goto_next_reference()
end, { desc = "Siguiente ocurrencia" })
vim.keymap.set("n", "[[", function()
  require("illuminate").goto_prev_reference()
end, { desc = "Anterior ocurrencia" })

vim.opt.hlsearch = true -- Resaltar búsquedas
vim.opt.incsearch = true -- Ir resaltando mientras escribes
-- Atajo para limpiar el resaltado con la tecla Esc
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
