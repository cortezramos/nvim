local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    vue = { "prettierd", "prettier", stop_after_first = true }, -- Agregado para Vue
    --java = { "google_java_format" }, -- Agregado para Java
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
