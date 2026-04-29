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

-- VTSLS: TypeScript Language Server con soporte para Vue y Next.js
lspconfig.vtsls.setup {
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

  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      tsdk = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/typescript/lib",
      preferences = {
        importModuleSpecifier = "relative",
      },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
}

-- VOLAR: Vue Language Server - SOLO maneja archivos .vue
lspconfig.volar.setup {
  on_attach = on_attach_custom,
  capabilities = nvlsp.capabilities,

  on_init = function(client)
    nvlsp.on_init(client)

    local retries = 0

    local function typescriptHandler(_, result, context)
      local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })[1]
        or vim.lsp.get_clients({ bufnr = context.bufnr, name = "ts_ls" })[1]
        or vim.lsp.get_clients({ bufnr = context.bufnr, name = "typescript-tools" })[1]

      if not ts_client then
        if retries <= 10 then
          retries = retries + 1
          vim.defer_fn(function()
            typescriptHandler(_, result, context)
          end, 100)
        else
          vim.notify(
            "Could not find `vtsls` lsp client required by volar. Make sure vtsls is running.",
            vim.log.levels.ERROR
          )
        end
        return
      end

      local param = result and result[1] or result
      if not param then return end

      local id, command, payload = param[1], param[2], param[3]
      ts_client:exec_cmd({
        title = "vue_request_forward",
        command = "typescript.tsserverRequest",
        arguments = { command, payload },
      }, { bufnr = context.bufnr }, function(_, r)
        local response_data = { { id, r and r.body } }
        client:notify("tsserver/response", response_data)
      end)
    end

    client.handlers["tsserver/request"] = typescriptHandler
  end,

  root_dir = lspconfig.util.root_pattern(
    "vite.config.ts",
    "vite.config.js",
    "vue.config.js",
    "vue.config.ts",
    "nuxt.config.js",
    "nuxt.config.ts",
    "package.json"
  ),

  filetypes = { "vue" },
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

-- Java Language Server (jdtls) Configuration
-- Nota: Para Java, lo ideal es usar nvim-jdtls que es más robusto que lspconfig
-- Esta es una configuración básica que debería funcionar para goto implementation
lspconfig.jdtls.setup {
  on_attach = function(client, bufnr)
    -- Llamar al on_attach estándar de nvchad
    nvlsp.on_attach(client, bufnr)
    
    -- Función helper para crear preview flotante manualmente (para evitar el bug de goto-preview con jdtls)
    local function preview_location(location, context)
      if not location then return end
      
      local uri = location.uri or location.targetUri
      local range = location.range or location.targetRange or location.targetSelectionRange
      
      if not uri or not range then return end
      
      -- Convertir URI a path
      local filepath = vim.uri_to_fname(uri)
      
      -- Leer el archivo
      local bufnr_preview = vim.fn.bufadd(filepath)
      vim.fn.bufload(bufnr_preview)
      local lines = vim.api.nvim_buf_get_lines(bufnr_preview, 0, -1, false)
      
      -- Calcular rango de líneas a mostrar (contexto de ±15 líneas)
      local start_line = math.max(0, range.start.line - 15)
      local end_line = math.min(#lines, range.start.line + 30)
      local preview_lines = vim.list_slice(lines, start_line + 1, end_line)
      
      -- Crear buffer temporal para el preview
      local preview_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(preview_buf, 0, -1, false, preview_lines)
      
      -- Detectar filetype
      local ft = vim.filetype.match({ filename = filepath })
      if ft then
        vim.api.nvim_buf_set_option(preview_buf, 'filetype', ft)
      end
      
      -- Configurar ventana flotante
      local width = math.min(120, vim.o.columns - 4)
      local height = math.min(25, vim.o.lines - 4)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)
      
      local opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = {"↖", "─" ,"↗", "│", "↘", "─", "↙", "│"},
        title = ' ' .. vim.fn.fnamemodify(filepath, ':t') .. ' ',
        title_pos = 'left',
      }
      
      local win = vim.api.nvim_open_win(preview_buf, true, opts)
      
      -- Posicionar cursor en la línea correcta
      local cursor_line = range.start.line - start_line + 1
      vim.api.nvim_win_set_cursor(win, {cursor_line, range.start.character})
      
      -- Cerrar con q o ESC
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = preview_buf, nowait = true })
      vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = preview_buf, nowait = true })
    end
    
    -- Función para preview de definición (Java-specific)
    local function java_preview_definition()
      local params = vim.lsp.util.make_position_params()
      vim.lsp.buf_request(bufnr, 'textDocument/definition', params, function(err, result, ctx, config)
        if err then
          vim.notify('Error al buscar definición: ' .. err.message, vim.log.levels.ERROR)
          return
        end
        
        if not result or vim.tbl_isempty(result) then
          vim.notify('No se encontró definición', vim.log.levels.WARN)
          return
        end
        
        -- Manejar resultado único o múltiple
        local location = vim.islist(result) and result[1] or result
        preview_location(location, 'definition')
      end)
    end
    
    -- Función para preview de implementación (Java-specific)
    local function java_preview_implementation()
      local params = vim.lsp.util.make_position_params()
      vim.lsp.buf_request(bufnr, 'textDocument/implementation', params, function(err, result, ctx, config)
        if err then
          vim.notify('Error al buscar implementación: ' .. err.message, vim.log.levels.ERROR)
          return
        end
        
        if not result or vim.tbl_isempty(result) then
          vim.notify('No se encontró implementación', vim.log.levels.WARN)
          return
        end
        
        -- Manejar resultado único o múltiple
        local location = vim.islist(result) and result[1] or result
        preview_location(location, 'implementation')
      end)
    end
    
    -- Sobrescribir gi para que vaya a implementación en Java
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {
      buffer = bufnr,
      desc = '[Java] Goto Implementation'
    })
    
    -- Sobrescribir gd para que vaya a definición en Java (comportamiento estándar)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
      buffer = bufnr,
      desc = '[Java] Goto Definition'
    })
    
    -- Sobrescribir <leader>gpd y <leader>gpi con las funciones personalizadas
    vim.keymap.set('n', '<leader>gpd', java_preview_definition, {
      buffer = bufnr,
      desc = '[Java] Preview Definition'
    })
    
    vim.keymap.set('n', '<leader>gpi', java_preview_implementation, {
      buffer = bufnr,
      desc = '[Java] Preview Implementation'
    })
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { 'jdtls' },
  root_dir = lspconfig.util.root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
  filetypes = { 'java' },
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
