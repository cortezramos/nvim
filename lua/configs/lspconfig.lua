local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- 1. Servidores que NO necesitan configuración especial
local servers = { "html", "cssls", "tailwindcss" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

local on_attach_custom = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  if client.name == "vue_ls" or client.name == "volar" or client.name == "vtsls" or client.name == "ts_ls" then
    client.server_capabilities.documentHighlightProvider = true
  end
end

-- Ruta al plugin de TypeScript para Vue (instalado vía Mason)
local vue_typescript_plugin = vim.fn.stdpath "data"
  .. "/mason/packages/node_modules/@vue/typescript-plugin"

-- TS_LS: maneja TS/JS y también el bloque <script> de archivos Vue
-- gracias al @vue/typescript-plugin
lspconfig.ts_ls.setup {
  on_attach = on_attach_custom,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,

  root_dir = lspconfig.util.root_pattern(
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    "next.config.js",
    "next.config.ts",
    "next.config.mjs",
    ".git"
  ),

  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },

  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_typescript_plugin,
        languages = { "vue" },
      },
    },
  },

  settings = {
    typescript = {
      preferences = {
        importModuleSpecifier = "relative",
      },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
      },
    },
  },
}

-- VUE_LS (Volar): maneja CSS/HTML del template Vue en hybrid mode
-- Requiere que ts_ls con @vue/typescript-plugin esté corriendo
-- Usa el nuevo API de Neovim 0.11 (lsp/ dir)
vim.lsp.config("vue_ls", {
  on_attach = on_attach_custom,
  capabilities = nvlsp.capabilities,
  filetypes = { "vue" },
})
vim.lsp.enable "vue_ls"

lspconfig.eslint.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
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
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󱁤 " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
