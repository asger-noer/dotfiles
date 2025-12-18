# ===================
# Common Configuration
# ===================
XDG_CONFIG_HOME="$HOME/.config"
EDITOR="zed --wait" # Set the editor to zed and wait for it to close before continuing.
TERM=xterm-256color

eval "$(zoxide init zsh)"

alias cd='z'
alias lg='lazygit'
alias lzd='lazydocker'
