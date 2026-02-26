-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "kanagawa",
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
    { txt = "🖥️ Menu", keys = "Spc e", cmd = ":NvimTreeToggle" },
    { txt = "  Restore Session", keys = "Spc q s", cmd = "lua require('persistence').load()" },
    { txt = "  Archivos Recientes", keys = "Spc f o", cmd = "Telescope oldfiles" },
    { txt = "󰈚  Nuevo Archivo Codigo", keys = "Spc n", cmd = "lua require('utils').smart_create_file()" },
    { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
    { txt = "󰈚  New File", keys = "Spc n", cmd = "enew" },
    { txt = "  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
    { txt = "󱋒  Solidarity Docs", keys = "Spc h g", cmd = "edit ~/Documents/Projects/ARCHIVES/guide.md" },
    { txt = "󰄉  Check Health", keys = "Spc c h", cmd = "checkhealth" },
  },
}

M.ui = {
  tabufline = {
    lazyload = false,
  },
}

return M
