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
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true, -- Sugiere código automáticamente mientras escribes
          debounce = 75, -- TIempo en milisegundospara mostrar una sugerencia
          keymap = {
            accept = "<M-Right>", -- Presiona Alt + L para aceptar la sugerencia
            accept_word = false, -- No aceptar solo la palabra sugerida
            accept_line = false, -- No aceptar toda la linea sugerida
            next = "<M-]>",   -- Alt + ] para la siguiente sugerencia
            prev = "<M-[>",   -- Alt + [ para la anterior
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
          ["."] = false
        }
      })
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
      distance_stop_animating = 0.1
    },
  },
  {
    "nvim-focus/focus.nvim",
    event = "VeryLazy",
    config = function()
      require("focus").setup({
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
        }
      })
    end,
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
    "folke/noice.nvim",
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
        bottom_search = true,    -- El buscador abajo, pero moderno
        command_palette = true,   -- ¡ESTO! Hace que los comandos floten al centro
        long_message_to_split = true,
        inc_rename = false,      -- Úsalo si tienes el plugin de rename
        lsp_doc_border = true,   -- Bordes elegantes para docs de funciones
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify", -- Notificaciones flotantes con estilo
    }
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
  }

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
