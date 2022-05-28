# Init variables
## Forces terminal to be English
export LC_ALL=C

# Simple variables
export DOTFILES="$HOME/.dotfiles"
export SHELL="/bin/zsh"
export ZSH="$HOME/.oh-my-zsh"
export CHROME_EXECUTABLE="google-chrome-stable"
export DENO_INSTALL="/home/juliette/.deno"

# Paths
export PATH="$HOME/bin:$HOME/spicetify-cli:$HOME/.tools/bin:$HOME/.cargo/bin:$DENO_INSTALL/bin:$PATH"

# Ensures that gpg uses my tty for the password
export GPG_TTY=$TTY
