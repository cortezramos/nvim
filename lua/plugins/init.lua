return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lspconfig"
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true, -- Sugiere código automáticamente mientras escribes
          debounce = 75, -- TIempo en milisegundospara mostrar una sugerencia
          keymap = {
            accept = "<M-Right>", -- Presiona Alt + L para aceptar la sugerencia
            accept_word = false, -- No aceptar solo la palabra sugerida
            accept_line = false, -- No aceptar toda la linea sugerida
            next = "<M-]>", -- Alt + ] para la siguiente sugerencia
            prev = "<M-[>", -- Alt + [ para la anterior
            dismiss = "<C-]>", -- Ctrl + ] para cerrar la sugerencia
          },
        },
        panel = { enabled = false }, -- Desactivado para no estorbar el flujo de NvChad
        filetypes = {
          markdown = true, -- Habilitar Copilot en archivos markdown,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      }
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      -- Ajusta la suavidad del efecto aquí
      cursor_color = "#e0af68", -- Color llamativo
      stiffness = 0.6,
      trailing_stiffness = 0.3,
      distance_stop_animating = 0.1,
    },
  },
  {
    "nvim-focus/focus.nvim",
    event = "VeryLazy",
    config = function()
      require("focus").setup {
        enable = true,
        autoresize = {
          enable = true,
          width = 120, -- Ancho del panel activo (ajústalo a tu gusto)
          min_width = 40, -- Ancho mínimo para paneles inactivos
        },
        excluded_filetypes = { "nvdash", "TelescopePrompt", "NvimTree", "toggleterm", "notify" },
        excluded_buftypes = { "nofile", "prompt", "popup", "terminal" },
        ui = {
          signcolumn = false, -- Limpia la columna de la izquierda en paneles inactivos
        },
      }
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit (Gentleman Mode)" } },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        dotfiles = true, -- Oculta los archivos ocultos (dotfiles)
      },
      sync_root_with_cwd = true, -- Sincroniza la raíz del árbol con el directorio de trabajo actual
      respect_buf_cwd = true, -- Respeta el directorio de trabajo del buffer
      -- Aquí van tus configuraciones existentes...
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = {
        side = "left",
        width = 30,
      },
      actions = {
        open_file = {
          quit_on_open = true, -- ESTA ES LA CLAVE: cierra el árbol al abrir un archivo
          resize_window = true,
        },
      },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- Se carga solo cuando abres un archivo
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize", "skiprtp" },
    },
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          background_colour = "#000000", -- Esto quita el error
          fps = 30,
          render = "default",
          stages = "fade", -- Animación suave de Gentleman
          timeout = 2000,
        },
      },
    },
    event = "VeryLazy",
    opts = {
      -- Aquí puedes configurar qué tan agresivo quieres el cambio visual
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.styled_pa_lines"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true, -- El buscador abajo, pero moderno
        command_palette = true, -- ¡ESTO! Hace que los comandos floten al centro
        long_message_to_split = true,
        inc_rename = false, -- Úsalo si tienes el plugin de rename
        lsp_doc_border = true, -- Bordes elegantes para docs de funciones
      },
    },
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- Para los iconos de Java, Python, etc.
    },
    opts = {
      -- Puedes dejarlo vacío para el estilo por defecto o personalizarlo
      show_modified = true,
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- Se ejecuta justo antes de guardar
    opts = {
      formatters_by_ft = {
        -- Para Java: Usamos google-java-format
        java = { "google-java-format" },
        -- Para Vue, JS, TS, HTML y CSS: Usamos Prettier
        javascript = { "prettier" },
        typescript = { "prettier" },
        vue = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
      },
      format_on_save = {
        -- Estos ajustes son para que no se trabe el editor
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
      -- Ignorar ventanas de plugins para que no se abran vacías
      session_lens = {
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
    },
  },
  -- En tu lua/plugins/init.lua, busca donde está luasnip o añádelo:
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require "nvchad.configs.luasnip" -- Carga la base de NvChad
      local ls = require "luasnip"
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      -- Snippets de Java
      ls.add_snippets("java", {
        -- jm -> Java Method
        s("jm", {
          t "public ",
          i(1, "void"),
          t " ",
          i(2, "methodName"),
          t "(",
          i(3),
          t ") {",
          t { "", "\t" },
          i(0),
          t { "", "}" },
        }),
        -- psv -> Public Static Void Main
        s("psv", {
          t "public static void main(String[] args) {",
          t { "", "\t" },
          i(0),
          t { "", "}" },
        }),
        -- const -> Constructor
        s("const", {
          t "public ",
          i(1, "ClassName"),
          t "(",
          i(2),
          t ") {",
          t { "", "\t" },
          i(0),
          t { "", "}" },
        }),
      })

      ls.add_snippets("vue", {
        -- vref -> Crear una variable reactiva
        s("vref", {
          t "const ",
          i(1, "myVar"),
          t " = ref(",
          i(2, "null"),
          t ");",
        }),
        -- vcomp -> Crear una propiedad computada
        s("vcomp", {
          t "const ",
          i(1, "computedVar"),
          t " = computed(() => {",
          t { "", "  return " },
          i(0),
          t { "", "});" },
        }),
        -- vfor -> Estructura de un v-for rápido
        s("vfor", {
          t '<div v-for="',
          i(1, "item"),
          t " in ",
          i(2, "items"),
          t '" :key="',
          i(3, "item.id"),
          t '">',
          t { "", "  " },
          i(0),
          t { "", "</div>" },
        }),
      })
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
