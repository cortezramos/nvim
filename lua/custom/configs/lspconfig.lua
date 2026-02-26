local lspconfig = require "lspconfig"
local nv_lsp = require "nvchad.configs.lspconfig"

local on_attach = nv_lsp.on_attach
local on_init = nv_lsp.on_init
local capabilities = nv_lsp.capabilities

-- 1. Servidores básicos (HTML, CSS)
local servers = { "html", "cssls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- Configuración de TypeScript (ts_ls)
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
        languages = { "vue" },
      },
    },
  },

  -- Evitamos que ts_ls choque con vue_ls en archivos .vue
  filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
}

-- Configuración de VUE (Solución definitiva)
lspconfig.vue_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    vue = {
      hybridMode = false, -- Cambiar a false suele quitar el error de "could not find lsp client"
    },
    typescript = {
      -- Usamos la función de arriba para obtener la ruta real
      tsdk = vim.fn.stdpath "data" .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
    },
  },
}
