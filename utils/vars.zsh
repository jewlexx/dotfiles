# Init variables
## Forces terminal to be English
export LC_ALL=C

# Simple variables
export DOTFILES="$HOME/.dotfiles"
export DENO_INSTALL="$HOME/.deno"
export ZSH="$HOME/.oh-my-zsh"
export SHELL="/bin/zsh"

if command -v google-chrome-stable; then
    export CHROME_EXECUTABLE="google-chrome-stable"
else
    export CHROME_EXECUTABLE="chromium"
fi

# Paths
export PATH="$HOME/bin:$HOME/spicetify-cli:$HOME/.tools/bin:$HOME/.cargo/bin:$DENO_INSTALL/bin:$PATH"

# Ensures that gpg uses my tty for the password
export GPG_TTY=$TTY
