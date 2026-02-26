local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- 1. Servidores que NO necesitan configuración especial
local servers = { "html", "cssls", "jdtls", "tailwindcss" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Forzar capacidades de resaltado si el servidor no las reporta
local on_attach_custom = function(client, bufnr)
  -- Llamamos al on_attach original de NvChad
  nvlsp.on_attach(client, bufnr)

  -- Si es volar o ts_ls, forzamos el soporte de iluminación
  if client.name == "volar" or client.name == "ts_ls" then
    client.server_capabilities.documentHighlightProvider = true
  end
end

lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach_custom,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = {
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "javascript",
    "javascriptreact",
    "javascript.jsx",
  },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
        languages = { "vue" },
      },
    },
  },
}

lspconfig.volar.setup {
  on_attach = nvlsp.on_attach_custom,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = vim.fn.stdpath "data" .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
    },
  },
}

lspconfig.eslint.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  -- No le pases 'settings' complejos por ahora,
  -- deja que lea el .eslintrc.json por su cuenta.
  on_new_config = function(config, new_root_dir)
    config.settings.workspaceFolder = {
      uri = vim.uri_from_fname(new_root_dir),
      name = vim.fn.fnamemodify(new_root_dir, ":t"),
    }
  end,
  settings = {
    workingDirectory = {
      mode = "auto",
    },
    experimental = {
      useFlatConfig = true,
    },
  },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "html" },
}

vim.diagnostic.config {
  virtual_text = true, -- Muestra el texto del error al lado de la línea
  signs = true, -- Muestra iconos en la columna de la izquierda
  underline = true, -- Subraya el código con error
  update_in_insert = false, -- Actualiza mientras escribes
  severity_sort = true,
}

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󱁤 " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
