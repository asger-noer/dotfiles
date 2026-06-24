export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="zed --wait" # Set the editor to zed and wait for it to close before continuing.

# # Initialize zsh's completion system.
autoload -Uz compinit
compinit

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Homegrown setup scripts
source ~/.config/zsh/setup/gpg.zsh
source ~/.config/zsh/setup/zoxide.zsh
source ~/.config/zsh/setup/alias.zsh
source ~/.config/zsh/setup/zinit.zsh
source ~/.config/zsh/setup/starship.zsh


# Load Lunar setup (depends on zinit and compinit being initialized above)
# Work plugins
if [ -f ~/.zshrc_lw ]; then
	source ~/.zshrc_lw
fi
