# GUIA MAESTRA NEOVIM — ECR7

> Tema: **aylin** | Leader: `Space` | Shell: **fish** | Explorador: **oil.nvim**

---

## ESTETICA Y UI

| Configuracion | Detalle |
| :--- | :--- |
| Tema | `aylin` con transparencia activada (requiere Blur en Warp) |
| Cursor | Barra en modo Insert, bloque en Normal |
| Linea activa | `CursorLine` resaltada en `#343944`, numero en amarillo |
| Separadores | `┃` en azul (`#7aa2f7`) entre paneles |
| Focus.nvim | Panel activo se expande a `120` columnas, minimo `40` |
| Smear Cursor | Estela animada al saltar entre lineas (color `#e0af68`) |
| Winbar | Muestra ruta del archivo + linea/columna en la barra superior |
| Incline | Nombre del archivo flotante en la esquina superior derecha |
| Barbecue | Breadcrumb de navegacion LSP en la parte superior |

---

## DASHBOARD (Pantalla de inicio)

Se abre automaticamente al iniciar nvim.

| Atajo en Dashboard | Accion |
| :--- | :--- |
| `-` | Abrir Oil (explorador de archivos) |
| `Space f o` | Archivos recientes |
| `Space f f` | Buscar archivos |
| `Space n` | Nuevo archivo |
| `Space h g` | Abrir esta guia |
| `Space c h` | `:checkhealth` |
| `Space d a` | Volver al Dashboard desde cualquier lugar |

---

## NAVEGACION LSP (ESTILO INTELLIJ)

> Aplica a Java (jdtls via Telescope), TypeScript, Vue, etc.

| Atajo | Accion | Descripcion |
| :--- | :--- | :--- |
| `g d` | Go to Definition | Ir a la clase o interfaz |
| `g i` | Go to Implementation | Saltar de Interfaz a Service/Adapter |
| `g r` | Go to References | Ver quien usa este metodo |
| `<leader> c a` | Code Actions | Implementar metodos, importar clases |
| `<M-p>` (Alt+P) | Code Actions (alternativo) | Estilo IntelliJ Alt+Enter |
| `<leader> r n` | Rename | Renombrar simbolo en todo el proyecto |
| `<leader> o i` | Organize Imports | Limpiar imports de Java |
| `<leader> f m` | Format | Formatear archivo (Conform + LSP fallback) |
| `Ctrl + o` | Jump Back | Volver al archivo/posicion anterior |
| `Ctrl + i` | Jump Forward | Avanzar en el historial de saltos |
| `]]` | Siguiente ocurrencia | Navegar entre usos del simbolo bajo el cursor (Illuminate) |
| `[[` | Ocurrencia anterior | Navegar hacia atras entre usos (Illuminate) |

---

## BUSCADOR (SNACKS PICKER)

> Reemplaza Telescope como picker principal.

| Atajo | Accion |
| :--- | :--- |
| `<leader> f f` | Buscar archivos en el proyecto |
| `<leader> f g` | Grep (buscar texto en todos los archivos) |
| `<leader> f w` | Grep (igual que `fg`) |
| `<leader> f b` | Lista de buffers abiertos |
| `<leader> f r` | Archivos recientes |
| `<leader> f h` | Paginas de ayuda de nvim |
| `<leader> f k` | Ver todos los keymaps |
| `<leader> f s` | Smart Find (busqueda inteligente) |
| `<leader> f p` | Proyectos recientes |
| `<leader> .` | Buscar lineas en el buffer actual |
| `<F12>` | Buscar implementacion por texto (palabra bajo cursor) |

### Dentro del Picker

| Tecla | Accion |
| :--- | :--- |
| `Ctrl + j` | Scroll preview hacia abajo |
| `Ctrl + k` | Scroll preview hacia arriba |
| `Ctrl + g` | Narrow: refinar la busqueda actual |

---

## EXPLORADOR DE ARCHIVOS (OIL.NVM)

> `-` abre el directorio del archivo actual. `Ctrl + e` abre flotante.

| Atajo | Accion |
| :--- | :--- |
| `-` | Abrir Oil en el directorio del archivo actual |
| `Ctrl + e` | Abrir Oil en modo flotante |
| `q` (dentro de Oil) | Cerrar Oil y volver al Dashboard |
| `<leader> x` | Cerrar buffer actual y abrir Oil en su directorio |
| `Enter` | Entrar al directorio / abrir archivo |
| `-` (dentro de Oil) | Subir al directorio padre |

> Oil permite **editar el sistema de archivos como texto**: renombrar, mover, eliminar con `:w`.

---

## GESTION DE PANELES (SPLITS)

| Atajo | Accion |
| :--- | :--- |
| `:vsplit` | Crear panel vertical |
| `Ctrl + h` | Moverse al panel izquierdo (se expande con Focus.nvim) |
| `Ctrl + l` | Moverse al panel derecho (se expande con Focus.nvim) |
| `Alt + h` | Navegar izquierda (funciona en terminal tambien) |
| `Alt + l` | Navegar derecha (funciona en terminal tambien) |
| `Ctrl + h` (en terminal) | Saltar al panel de codigo (izquierda) |
| `Ctrl + l` (en terminal) | Saltar al panel de la terminal (derecha) |

---

## GESTION DE BUFFERS (PESTANAS)

| Atajo | Accion |
| :--- | :--- |
| `Tab` | Siguiente buffer/archivo abierto |
| `Shift + Tab` | Buffer anterior |
| `<leader> x` | Cerrar buffer actual (abre Oil en su directorio) |
| `<leader> b a` | Cerrar todos los buffers abiertos |
| `<leader> f b` | Lista de buffers (via Snacks Picker) |

---

## EDICION DE CODIGO

| Atajo | Accion |
| :--- | :--- |
| `g c c` | Comentar/descomentar linea actual |
| `g c` (visual) | Comentar bloque seleccionado |
| `w` / `b` | Saltar palabra por palabra (adelante/atras) |
| `%` | Saltar entre llaves `{}` o parentesis `()` |
| `> >` | Indentar linea (derecha) |
| `< <` | Quitar indentacion (izquierda) |
| `Tab` (visual) | Indentar seleccion a la derecha |
| `Shift + Tab` (visual) | Indentar seleccion a la izquierda |
| `J` (visual) | Mover bloque seleccionado hacia abajo |
| `K` (visual) | Mover bloque seleccionado hacia arriba |
| `u` | Deshacer (Undo) |
| `Ctrl + r` | Rehacer (Redo) |
| `y y` | Copiar linea completa (va al clipboard del sistema) |
| `y` | Copiar seleccion (va al clipboard del sistema) |
| `p` | Pegar |
| `=` (visual) | Auto-indentar seleccion |
| `<Esc>` | Limpiar resaltado de busqueda |

---

## SNIPPETS DE CODIGO

### Java

| Trigger | Snippet generado |
| :--- | :--- |
| `jm` | Metodo Java: `public void methodName() {}` |
| `psv` | `public static void main(String[] args) {}` |
| `const` | Constructor de clase |
| `<leader> s j` | Insertar estructura base de clase Java (con package) |

### Vue

| Trigger | Snippet generado |
| :--- | :--- |
| `vref` | `const myVar = ref(null)` |
| `vcomp` | `const computedVar = computed(() => { return })` |
| `vfor` | `<div v-for="item in items" :key="item.id">` |
| `<leader> s v` | Insertar estructura base de componente Vue 3 |

---

## PORTAPAPELES

- Configurado con `unnamedplus`: todo `y`/`d` va directo al clipboard del sistema macOS.
- No necesitas `"+y`, simplemente `y` copia y `p` pega desde/hacia otras apps.

---

## DEBUGGING (JAVA — DAP)

> La UI se abre automaticamente al iniciar el debugger y se cierra al terminar.

| Tecla | Accion |
| :--- | :--- |
| `<F5>` | Start / Continue |
| `<F8>` | Step Over (siguiente linea) |
| `<F7>` | Step Into (entrar al metodo) |
| `<leader> d b` | Toggle Breakpoint |
| `<leader> d u` | Toggle DAP UI (variables, stack, watches) |

> El debugger se conecta por **attach remoto** en `127.0.0.1:5005`.
> Breakpoint visual: 🐛 | Linea activa: 🤓

### Configurar debug en Spring Boot

```bash
# En build.gradle o como VM option al correr la app:
-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005
```

---

## GIT (LAZYGIT)

| Atajo | Accion |
| :--- | :--- |
| `<leader> g g` | Abrir LazyGit (TUI completo de Git) |

---

## SESIONES (PERSISTENCE.NVM)

Las sesiones se guardan automaticamente al cerrar nvim.

| Atajo | Accion |
| :--- | :--- |
| `<leader> q s` | Restaurar sesion del directorio actual |
| `<leader> q l` | Restaurar la ultima sesion global |

---

## ENFOQUE Y ZEN

| Atajo | Accion |
| :--- | :--- |
| `<leader> t w` | Toggle Twilight (atenua el codigo fuera del bloque actual) |
| `<leader> z` | Toggle ZenMode (pantalla limpia, sin distracciones) |

---

## SCREENKEY (MOSTRAR TECLAS EN PANTALLA)

Util para demos, grabaciones de pantalla o pair programming.

| Atajo | Accion |
| :--- | :--- |
| `<leader> s k` | Toggle Screenkey (mostrar/ocultar teclas presionadas) |

---

## COMANDOS DE RESCATE

### Dentro de Neovim

| Comando | Cuando usarlo |
| :--- | :--- |
| `:LspRestart` | Reiniciar LSP si hay lentitud o errores raros |
| `:LspInfo` | Verificar que `jdtls` / `vtsls` esten activos en el buffer |
| `:JdtUpdateConfig` | Sincronizar cambios de `pom.xml` o `build.gradle` |
| `:checkhealth` | Diagnostico general del entorno nvim |
| `:Mason` | Abrir gestor de LSPs, linters y formateadores |
| `:Lazy` | Ver/actualizar plugins |
| `:Lazy sync` | Sincronizar todos los plugins |

### En Terminal (Limpieza de Cache)

```bash
# Limpiar workspace de JDTLS (Mac)
pkill -9 java && rm -rf ~/.cache/jdtls/workspace/*

# Ver logs del LSP
:LspLog
```

---

## FORMATEO AUTOMATICO (CONFORM)

Se ejecuta automaticamente al guardar (`:w`).

| Lenguaje | Formateador |
| :--- | :--- |
| Lua | `stylua` |
| JavaScript / TypeScript | `prettierd` (fallback: `prettier`) |
| Vue | `prettierd` (fallback: `prettier`) |
| CSS / HTML | `prettier` |

Tambien se puede forzar manualmente con `<leader> f m`.

---

## LSP ACTIVOS

| Servidor | Lenguajes |
| :--- | :--- |
| `jdtls` | Java (con Lombok, debug adapter, java-test) |
| `vtsls` | TypeScript, JavaScript, JSX/TSX, Vue |
| `volar` | Vue (`.vue` exclusivamente) |
| `eslint` | JS, TS, JSX, TSX, Vue, HTML |
| `html` | HTML |
| `cssls` | CSS |
| `tailwindcss` | Tailwind CSS |
| `sonarlint` | Java (analisis de calidad de codigo) |

---

## ATAJOS RAPIDOS VARIOS

| Atajo | Accion |
| :--- | :--- |
| `;` | Entrar al modo comando (igual que `:`) |
| `j k` (Insert) | Salir al modo Normal (ESC alternativo) |
| `<leader> d a` | Abrir Dashboard |
