# ⚡ GUÍA MAESTRA NEOVIM

## 🎨 ESTÉTICA Y UI
- **Transparencia:** Activada en `chadrc.lua` (Requiere Blur en Warp).
- **Focus.nvim:** Panel activo se expande a `120`.
- **Marcos:** Separadores sólidos `┃` entre paneles.
- **Smear Cursor:** Estela animada al saltar entre líneas.

## 🚀 NAVEGACIÓN Y EDICIÓN (ESTILO INTELLIJ)
| Atajo | Acción | Descripción |
| :--- | :--- | :--- |
| `g d` | Go to Definition | Ir a la clase o interfaz. |
| `g i` | Go to Implementation | Saltar de Interfaz a Service/Adapter. |
| `g r` | Go to References | Ver quién usa este método. |
| `<leader> c a` | Code Actions | **Alt+Enter:** Implementar métodos, importar. |
| `<leader> r a` | Rename | Renombrar en todo el proyecto. |
| `<leader> o i` | Organize Imports | Limpiar imports de Java. |
| `Ctrl + o` | Jump Back | Volver al archivo anterior. |
| `Space + e` | File Explorer | Abrir/Cerrar NvimTree (árbol de archivos). |

## 🪟 GESTIÓN DE PANELES (SPLITS)
| Atajo | Acción |
| :--- | :--- |
| `:vsplit` | Crear panel vertical. |
| `Ctrl + h` | Moverse al panel IZQUIERDO (se expande). |
| `Ctrl + l` | Moverse al panel DERECHO (se expande). |
| `Space + x` | Cerrar buffer actual. |
| `Space + d b`| Abrir Dashboard Solidarity. |

## 📋 PORTAPAPELES (CLIPBOARD)
- **Copiar:** `y` (al sistema automáticamente).
- **Pegar:** `p`.
- **Copiar línea:** `y y`.
- **Auto-identar:** Seleccionar con `v` y presionar `=`.

## 🐞 DEBUGGING (JAVA)
| Tecla | Acción |
| :--- | :--- |
| `<F5>` | Start / Continue. |
| `<F10>` | Step Over (Siguiente línea). |
| `<F11>` | Step Into (Entrar a método). |
| `<S-F11>` | Step Out (Salir de método). |
| `<leader> d b` | Toggle Breakpoint (Punto rojo). |
| `:DapUiToggle` | Ver variables y Stack. |

## 🚑 RESCATE RÁPIDO
- **Reiniciar Java:** `:LspRestart`.
- **Sincronizar Gradle/Maven:** `:JdtUpdateConfig`.
- **Limpiar Todo:** `pkill -9 java && rm -rf ~/.cache/jdtls/workspace/*`.

## 🚑 5. COMANDOS DE RESCATE
Si el entorno deja de reconocer clases o falla el autocompletado.

🔹 Dentro de Neovim:
:JdtUpdateConfig: Sincroniza cambios si agregaste dependencias en pom.xml o build.gradle.

:LspRestart: Reinicia el servidor si notas lentitud.

:LspInfo: Verifica que el cliente jdtls esté activo en el buffer.

##🔹 En Terminal (Limpieza de Caché):
Mac:

## ⌨️ ATAJOS EXTRAS DE EDICIÓN
| Atajo | Acción |
| :--- | :--- |
| `gcc` | Comentar/Descomentar línea actual. |
| `gc` (en visual) | Comentar bloque seleccionado. |
| `w` / `b` | Saltar palabra por palabra (adelante/atrás). |
| `%` | Saltar entre llaves `{ }` o paréntesis `( )`. |
| `> >` | Indentar línea (hacia la derecha). |
| `< <` | Quitar indentación (hacia la izquierda). |
| `u` | Deshacer (Undo). |
| `Ctrl + r` | Rehacer (Redo). |

## 📑 GESTIÓN DE PESTAÑAS (BUFFERS)
| Atajo | Acción |
| :--- | :--- |
| `Tab` | Siguiente pestaña/archivo abierto. |
| `Shift + Tab` | Pestaña anterior. |
| `<leader> x` | Cerrar pestaña actual (cierra archivo). |
| `<leader> b a`| Cerrar todos los archivos abiertos. |

Bash
pkill -9 java && rm -rf ~/.cache/jdtls/workspace/*

##🪟 6. GESTIÓN DE VENTANAS (SPLITS)
Útil para ver dos capas de la arquitectura al mismo tiempo.

Ctrl + h/j/k/l: Moverse entre ventanas (izquierda, abajo, arriba, derecha).

:vsplit: Divide la pantalla verticalmente.

<leader> x: Cierra el buffer/pestaña actual.

<leader>ff: Buscar archivos (sin target gracias al paso anterior).

<leader>fw: Buscar texto dentro de los archivos.

<leader>ds: Ver todos los métodos y variables de la clase actual (el "Structure" de IntelliJ).
