# 1. Rutas de Sistema (Vital para Mac Apple Silicon)
# Esto asegura que Fish encuentre 'node', 'npm' y 'brew'
fish_add_path /usr/local/bin
fish_add_path /opt/homebrew/bin

fish_add_path "$HOME/.local/share/nvim/mason/bin"
#fish_add_path /Users/ecortez/.local/share/nvim/mason/bin

# 2. Configuración de NVM para Fish
# Si instalaste el plugin 'juch/fish-nvm' con fisher, esto lo activa:
set -gx NVM_DIR "$HOME/.local/share/nvm"
#set -g nvm_default_version v25.6.1

if type -q nvm
    set -l current_node (nvm list | grep "default" | awk '{print $2}')
    
    if test -n "$current_node"
        set -g nvm_default_version $current_node
    else
        set -g nvm_default_version v25.6.1
    end

    nvm use $nvm_default_version --silent
    # Exportar el binario de la versión actual al PATH global
    #set -gx PATH $PATH $HOME/.nvm/versions/node/$nvm_default_version/bin
    fish_add_path "$NVM_DIR/$nvm_default_version/bin"
end

# 3. Comandos para sesiones interactivas
if status is-interactive
    # Inicializar herramientas visuales
    starship init fish | source
    zoxide init fish | source
    
    # Quitar saludo inicial
    set -g fish_greeting ""

end

