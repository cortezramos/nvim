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
  local nvlsp = require "nvchad.configs.lspconfig"
  nvlsp.on_attach(client, bufnr)

  -- 2. Forzar documentHighlight para illuminate
  client.server_capabilities.documentHighlightProvider = true

  -- 3. Setup DAP para debugging
  require("jdtls").setup_dap { hotcodereplace = "auto" }

  -- 4. Mapeos específicos para Java
  local map = vim.keymap.set

  -- Ir a Definición
  map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Java: Goto Definition" })

  -- Ir a Implementación
  map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Java: Goto Implementation" })

  -- Preview de Definición (goto-preview)
  map("n", "<leader>gpd", require("goto-preview").goto_preview_definition, { buffer = bufnr, desc = "Java: Preview Definition" })

  -- Preview de Implementación (goto-preview)
  map("n", "<leader>gpi", require("goto-preview").goto_preview_implementation, { buffer = bufnr, desc = "Java: Preview Implementation" })

  -- Cerrar todos los previews
  map("n", "<leader>gpc", require("goto-preview").close_all_win, { buffer = bufnr, desc = "Java: Close Preview Windows" })

  -- Ver Referencias
  map("n", "gr", [[<cmd>Telescope lsp_references<CR>]], { buffer = bufnr, desc = "Java: References" })

  -- Acciones de código
  map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP Code Actions" })

  -- Organizar Imports automáticamente (Opcional pero recomendado)
  map(
    "n",
    "<leader>oi",
    [[<cmd>lua require('jdtls').organize_imports()<CR>]],
    { buffer = bufnr, desc = "Organize Imports" }
  )

end

config.on_attach = on_attach

-- Asegurarnos de usar las mismas capabilities que los otros LSP
local nvlsp = require "nvchad.configs.lspconfig"
config.capabilities = nvlsp.capabilities

require("jdtls").start_or_attach(config)
