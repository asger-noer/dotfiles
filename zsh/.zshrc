XDG_CONFIG_HOME="$HOME/.config"
EDITOR="zed --wait" # Set the editor to zed and wait for it to close before continuing.

# Homegrown setup scripts
source ~/.config/zsh/setup/gpg.zsh
source ~/.config/zsh/setup/zoxide.zsh
source ~/.config/zsh/setup/alias.zsh

# Load Lunar setup (includes zplug initialization and loading)
source ~/.zshrc_lw
