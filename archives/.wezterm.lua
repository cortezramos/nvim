local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_background_opacity = 0.85
config.macos_window_background_blur = 25
config.use_dead_keys = false 
config.keys = {
  {
    key = ']',
    mods = 'CTRL',
    -- Esto envía el símbolo directamente sin esperar a nada
    action = wezterm.action.SendString '~', 
  },
  {
    key = 'raw:30', 
    mods = 'CTRL',
    action = wezterm.action.SendString '~',
  },
}
-- Configura la tecla Option derecha para caracteres especiales (tilde, ñ)
-- y la tecla Option izquierda para comandos de Neovim (Meta)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

-- --------------------------------------------------------

config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Regular" })

-- Tamaño de la fuente (ajusta el 14.0 a tu gusto)
config.font_size = 13.0

-- --- ESTÉTICA EXTRA ---
config.color_scheme = 'Catppuccin Mocha'

-- Quitar la barra de título de arribaA
config.window_decorations = "RESIZE"

return config
