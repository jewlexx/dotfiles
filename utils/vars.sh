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
export PATH="$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.0.0/bin:$HOME/bin:$HOME/spicetify-cli:$HOME/.tools/bin:$HOME/.cargo/bin:$DENO_INSTALL/bin:$PATH"

# Ensures that gpg uses my tty for the password
export GPG_TTY=$TTY
