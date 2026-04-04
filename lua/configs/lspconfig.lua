local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

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
  if client.name == "volar" then
    client.server_capabilities.documentHighlightProvider = true
  end
end

lspconfig.volar.setup {
  on_attach = on_attach_custom,
  capabilities = nvlsp.capabilities,
  on_init = nvlsp.on_init,
  root_dir = lspconfig.util.root_pattern("package.json", "vite.config.ts", "vite.config.js", "vue.config.js"),
  filetypes = { "vue" },
  settings = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/typescript/lib",
    },
  },
}

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

-- Disable vtsls for vue files to avoid conflict with volar
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "vtsls" then
      local buf = vim.api.nvim_get_current_buf()
      local filetype = vim.bo[buf].filetype
      if filetype == "vue" then
        vim.lsp.stop_client(client)
      end
    end
  end,
})

local on_attach_custom = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  if client.name == "volar" then
    client.server_capabilities.documentHighlightProvider = true
  end
end

lspconfig.volar.setup {
  on_attach = on_attach_custom,
  capabilities = nvlsp.capabilities,
  on_init = nvlsp.on_init,
  root_dir = lspconfig.util.root_pattern("package.json", "vite.config.ts", "vite.config.js", "vue.config.js"),
  filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
  settings = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/typescript/lib",
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
