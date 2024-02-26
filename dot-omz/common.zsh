# ===================
# Common Configuration
# ===================
export EDITOR="zed --wait" # Set the editor to zed and wait for it to close before continuing.

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/Users/asger/go/bin:$PATH"
export PATH="/Users/asger/.cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

export TERM=xterm-256color

eval "$(zoxide init zsh)"

alias cd='z'
alias lg='lazygit'
alias lzd='lazydocker'

# Set up Go environment
alias go='go1.25.0'

# Set up Podman aliases
alias pms='podman machine start'
alias pms!='podman machine stop'
alias pcu='podman compose up --detach'
alias pcuw='podman compose up --detach --wait'
