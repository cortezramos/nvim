local lspconfig = require "lspconfig"
local nv_lsp = require "nvchad.configs.lspconfig"

local on_attach = nv_lsp.on_attach
local on_init = nv_lsp.on_init
local capabilities = nv_lsp.capabilities

lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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