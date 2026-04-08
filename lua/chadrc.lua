-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "aylin",
  transparency = true,
  hl_override = {
    CursorLine = {
      bg = "#343944",
      bold = true,
    },
    CursorLineNr = {
      fg = "#ffdd33",
      bg = "#343944",
      bold = true,
    },
    LineNr = {
      fg = "#585b70",
    },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "                            ",
    "      ⚡ DEV CODER ⚡      ",
    "      { < MODO GOD > }      ",
    "     PROGRAMMING MODE ON    ",
    "             ECR7               ",
  },
  buttons = {
    {
      txt = "🖥️ Explorar archivos",
      keys = "-",
      cmd = "lua vim.schedule(function() require('oil').open(vim.fn.getcwd()) end)",
    },
    { txt = "  Archivos Recientes", keys = "Spc f o", cmd = "Telescope oldfiles" },
    { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
    { txt = "󰈚  New File", keys = "Spc n", cmd = "enew" },
    { txt = "  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
    { txt = "󱋒  Solidarity Docs", keys = "Spc h g", cmd = "edit ~/.config/nvim/archives/guide.md" },
    { txt = "󰄉  Check Health", keys = "Spc c h", cmd = "checkhealth" },
  },
}

M.ui = {
  tabufline = {
    lazyload = false,
  },
  statusline = {
    enabled = false,
  },
}

return M
