if status is-interactive
    # Comandos para sesiones interactivas
    starship init fish | source
    # Esto activa zoxide (el comando 'z')
    zoxide init fish | source
end

# Quitar el mensaje de bienvenida feo de fish
set -g fish_greeting ""

starship init fish | source
