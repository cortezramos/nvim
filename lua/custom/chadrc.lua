--Este es el archivo que toma la v2.5

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "darcula-dark",
  transparency = true,
}

M.ui = {
  icons = true,
  statusline = { theme = "vscode" },
  nvdash = {
    load_on_startup = true, -- CARGAR AL INICIO: Esto responde a tu duda
    header = {
      " ",
      " ",
      "{ < MODO GOD > }",
      " ",
      " ",
    },
    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  New File", "Spc n", "enew" }, -- CREAR ARCHIVO DESDE AQUÍ
      { "  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󱋒  Solidarity Docs", "Spc h g", "edit ~/Documents/Projects/ARCHIVES/guide.md" }, -- TU GUÍA
      { "󰄉  Check Health", "Spc c h", "checkhealth" },
    },
    header_cache = false,
  },
}

return M

