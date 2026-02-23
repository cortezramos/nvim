local home = os.getenv "HOME"
local lombok_path = os.getenv "HOME" .. "/lombok.jar"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name
local mason_path = vim.fn.stdpath "data" .. "/mason/bin/jdtls"

local config = {
  -- Usamos la ruta completa al binario de Mason
  cmd = {
    mason_path,
    "-data",
    workspace_dir,
    "--jvm-arg=-Xmx2g",
    "--jvm-arg=-javaagent:" .. lombok_path,
  },
  root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1]),
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
    },
  },
}

-- Añadiendo java-test a los bundles:
local bundles = {}

local function add_to_bundles(path_pattern)
  local matches = vim.fn.glob(path_pattern, true, true) -- true, true → devuelve lista
  if #matches > 0 then
    vim.list_extend(bundles, matches)
  end
end

-- Añadir Debug Adapter (usa 'plugin', no 'helper')
add_to_bundles(
  vim.fn.stdpath "data" .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
)

-- Añadir Java Test (si existe)
add_to_bundles(vim.fn.stdpath "data" .. "/mason/packages/java-test/extension/server/*.jar")

config["init_options"] = {
  bundles = bundles,
}

local on_attach = function(client, bufnr)
  -- 1. Cargar los mapeos estándar de NvChad (esto trae la mayoría)
  pcall(function()
    require("nvchad.configs.lspconfig").on_attach(client, bufnr)
  end)

  require("jdtls").setup_dap { hotcodereplace = "auto" }

  -- 2. Forzar mapeos específicos para Java que a veces fallan
  local map = vim.keymap.set
  local opts = { buffer = bufnr, desc = "LSP Java" }

  -- Ir a Definición (usualmente Space + g + d en NvChad, lo ponemos directo en gd)
  map("n", "gd", [[<cmd>Telescope lsp_definitions<CR>]], { buffer = bufnr, desc = "Java Definition" })

  -- Ir a Implementación (ESTE ES EL QUE TE FALLA)
  map("n", "gi", [[<cmd>Telescope lsp_implementations<CR>]], { buffer = bufnr, desc = "Java Implementation" })

  -- Ver Referencias (Muy útil para ver quién usa el método)
  map("n", "gr", [[<cmd>Telescope lsp_references<CR>]], { buffer = bufnr, desc = "Java References" })

  -- Acciones de código (Para importar clases, etc.)
  map("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", { desc = "LSP Code Actions" })

  -- Organizar Imports automáticamente (Opcional pero recomendado)
  map(
    "n",
    "<leader>oi",
    [[<cmd>lua require('jdtls').organize_imports()<CR>]],
    { buffer = bufnr, desc = "Organize Imports" }
  )
end

config.on_attach = on_attach

require("jdtls").start_or_attach(config)
