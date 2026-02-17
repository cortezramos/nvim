local M = {}

M.smart_create_file = function()
  local telescope = require "telescope.builtin"
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  telescope.find_files {
    prompt_title = "Selecciona Carpeta Destino",
    find_command = {
      "find",
      ".",
      "-type",
      "d",
      "-not",
      "-path",
      "*/.*",
      "-not",
      "-path",
      "./target*",
      "-not",
      "-path",
      "./node_modules*",
    },
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        vim.ui.input({ prompt = "Nombre del archivo: " }, function(input)
          if input and input ~= "" then
            local path = selection.value .. "/" .. input
            vim.cmd("edit " .. path)
          end
        end)
      end)
      return true
    end,
  }
end

return M
