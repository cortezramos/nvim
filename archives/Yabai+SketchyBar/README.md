# Paso a paso para otra Mac - yabai + sketchybar

## 1. Instalar Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 2. Instalar apps
```bash
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew install FelixKratz/formulae/sketchybar
```

## 3. Crear carpetas
```bash
mkdir -p ~/.config/yabai ~/.config/skhd ~/.config/sketchybar/plugins
```

## 4. Copiar archivos desde archivos guardados (recomendado)
```bash
cp ~/.config/nvim/archives/yabairc ~/.config/yabai/
cp ~/.config/nvim/archives/skhdrc ~/.config/skhd/
cp ~/.config/nvim/archives/sketchybarrc ~/.config/sketchybar/
cp ~/.config/nvim/archives/space.sh ~/.config/sketchybar/plugins/
cp ~/.config/nvim/archives/move-window-to-space.sh ~/.config/yabai/
cp ~/.config/nvim/archives/focus-current-space-window.sh ~/.config/yabai/
```

## 5. Hacer scripts ejecutables
```bash
chmod +x ~/.config/yabai/*.sh
```

## 6. Dar permisos de accesibilidad
1. **System Settings** → **Privacy & Security** → **Accessibility**
2. Click **+** y agrega `/opt/homebrew/bin/yabai`
3. Click **+** y agrega `/opt/homebrew/bin/skhd`
4. Habilita las casillas

## 7. Crear espacios en Mission Control
1. Presiona **F3** o **Ctrl + Up Arrow**
2. Corner superior derecha → **+** para agregar desktops
3. Crea 7 espacios

## 8. Configurar atajos de Mission Control
1. **System Settings** → **Keyboard** → **Keyboard Shortcuts** → **Mission Control**
2. Habilita `Ctrl+1` hasta `Ctrl+7` para cada desktop

## 9. Iniciar servicios
```bash
yabai --start-service
skhd --start-service
brew services start sketchybar
```

## 10. Verificar
```bash
yabai -m query --spaces
```

## Atajos de teclado

| Atajo | Acción |
|-------|--------|
| `ctrl + alt + h/j/k/l` | Focus ventana |
| `ctrl + alt + shift + h/j/k/l` | Mover ventana |
| `ctrl + alt + 1-7` | Ir a espacio |
| `ctrl + alt + shift + 1-7` | Mover ventana a espacio |
| `ctrl + alt + Enter` | Fullscreen |
| `ctrl + alt + f` | Toggle floating |

## Archivos guardados en este directorio
- yabairc
- skhdrc
- sketchybarrc
- space.sh
- move-window-to-space.sh
- focus-current-space-window.sh
