return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        vue = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lspconfig"
    end,
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      require("incline").setup {
        window = {
          padding = 0,
          margin = { horizontal = 1, vertical = 0 },
          placement = { vertical = "top", horizontal = "right" },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end

          local devicons = require "nvim-web-devicons"
          local icon, color = devicons.get_icon_color(filename)
          local modified = vim.api.nvim_buf_get_option(props.buf, "modified")

          return {
            { " ", guifg = "#3b4261" },
            {
              { " " .. (icon or "") .. " ", guifg = color, guibg = "#3b4261" },
              {
                filename .. " ",
                gui = modified and "bold,italic" or "bold",
                guifg = modified and "#ff9e64" or "#c0caf5",
                guibg = "#3b4261",
              },
            },
            { " ", guifg = "#3b4261" },
          }
        end,
      }
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    event = { "CursorHold", "CursorHoldI" },
    config = function()
      require("illuminate").configure {
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 100,
        under_cursor = true,
        large_file_cutoff = 2000,
      }

      vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#3b4252", fg = "#ffdd33", underline = true, bold = true })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#3b4252", fg = "#ffdd33", underline = true, bold = true })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#444b5a", fg = "#ffdd33", underline = true, bold = true })
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
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
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
      cursor_color = "#e0af68",
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
          width = 120,
          min_width = 40,
        },
        excluded_filetypes = { "nvdash", "TelescopePrompt", "NvimTree", "oil", "toggleterm", "notify" },
        excluded_buftypes = { "nofile", "prompt", "popup", "terminal" },
        ui = {
          signcolumn = true,
        },
      }
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
  },

  -- NvimTree: desactivar hijack para que oil sea el explorador por defecto.
  -- Usamos opts como función para hacer merge con la base de NvChad
  -- y sobreescribir solo las claves que necesitamos.
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local base = require "nvchad.configs.nvimtree"
      return vim.tbl_deep_extend("force", base, {
        disable_netrw = false,
        hijack_netrw = false,
        hijack_directories = {
          enable = false,
          auto_open = false,
        },
        filters = { dotfiles = false },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
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
            quit_on_open = true,
            resize_window = true,
          },
        },
      })
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
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
          background_colour = "#000000",
          fps = 30,
          render = "default",
          stages = "fade",
          timeout = 2000,
        },
      },
    },
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.styled_pa_lines"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      show_modified = true,
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
  {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("sonarlint").setup {
        server = {
          cmd = {
            vim.fn.stdpath "data" .. "/mason/bin/sonarlint-language-server",
            "-stdio",
            "-analyzers",
            vim.fn.stdpath "data"
              .. "/mason/packages/sonarlint-language-server/extension/analyzers/sonarqube-java-plugin.jar",
          },
        },
        filetypes = { "java" },
      }
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require "nvchad.configs.luasnip"
      local ls = require "luasnip"
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("java", {
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
        s("psv", {
          t "public static void main(String[] args) {",
          t { "", "\t" },
          i(0),
          t { "", "}" },
        }),
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
        s("vref", {
          t "const ",
          i(1, "myVar"),
          t " = ref(",
          i(2, "null"),
          t ");",
        }),
        s("vcomp", {
          t "const ",
          i(1, "computedVar"),
          t " = computed(() => {",
          t { "", "  return " },
          i(0),
          t { "", "});" },
        }),
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

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
    },
  },

  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    opts = {
      dimming = {
        alpha = 0.25,
        inactive = false,
      },
      context = 10,
      treesitter = true,
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    opts = {
      window = {
        backdrop = 0.95,
        width = 0.8,
        height = 1,
        options = {
          number = false,
          relativenumber = false,
          foldcolumn = "0",
          list = false,
          showbreak = "NONE",
          signcolumn = "no",
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = true },
      },
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle ZenMode" },
    },
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        -- Salir de oil y volver al dashboard
        ["q"] = function()
          require("oil").close()
          local ok, nvdash = pcall(require, "nvchad.nvdash")
          if ok then
            nvdash.open()
          end
        end,
      },
    },
  },

  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    config = function()
      require("screenkey").setup {
        compress_after = 3,
        clear_after = 3,
        show_leader = true,
        group_mappings = true,
      }

      vim.keymap.set("n", "<leader>sk", "<cmd>Screenkey toggle<cr>", { desc = "Toggle Screenkey" })
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<c-j>"] = { "preview_scroll_down", mode = { "n", "i" } },
              ["<c-k>"] = { "preview_scroll_up", mode = { "n", "i" } },
            },
          },
        },
      },
      explorer = { enabled = true },
      notifier = { enabled = false },
      dashboard = { enabled = false },
      scope = { enabled = true },
      words = { enabled = false },
      input = { enabled = false },
      bufdelete = { enabled = false },
      zen = { enabled = false },
      scroll = { enabled = false },
      indent = { enabled = false },
      image = { enabled = false },
      lazygit = { enabled = false },
      git = { enabled = false },
      statuscolumn = { enabled = false },
      terminal = { enabled = false },
      toggle = { enabled = false },
    },
  },
}
