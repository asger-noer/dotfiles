# ===================
# SSH GPG Configuration
# https://developer.okta.com/blog/2021/07/07/developers-guide-to-gpg
# ===================
# configure SSH to use GPG
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# start gpg-agent, if it isn't started already
gpgconf --launch gpg-agent
gpg-connect-agent /bye
# the docs say to use: gpg-connect-agent /bye

# Set an environment variable to tell GPG the current terminal.
# https://unix.stackexchange.com/a/608921
export GPG_TTY=$TTY
gpg-connect-agent updatestartuptty /bye >/dev/null
