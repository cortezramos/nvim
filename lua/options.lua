require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
-- Cambia el color del texto fantasma de Copilot
vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#838383", ctermfg = 8 })

vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

vim.opt.shell = "/opt/homebrew/bin/fish"

vim.opt.laststatus = 3

vim.opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

-- Esto le da un color sutil a los bordes para que resalten
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7aa2f7", bg = "none" })

-- Esto hace que el cursor siempre sea una barra en modo insertar,
-- ayudándote a ver exactamente dónde vas a escribir.
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

vim.opt.conceallevel = 2 -- Esconde los símbolos de formato (*, #, _, etc.)
vim.opt.concealcursor = "nc" -- Los esconde en modo normal, pero los muestra al edita

vim.opt.updatetime = 250
vim.opt.winbar = "%f %m %= %l %c"
