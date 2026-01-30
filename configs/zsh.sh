#!/bin/zsh
start=$(date +%s%N)

unsetopt MULTIBYTE

function source-config {
  source "$DOTFILES/configs/zsh/$1.sh"
}

#region Plugins
PLUGINS_DIR="$HOME/.plugins"
# Download Znap, if it's not there yet.
[[ -r $PLUGINS_DIR/znap/znap.zsh ]] ||
  git clone --depth 1 -- \
    https://github.com/marlonrichert/zsh-snap.git $PLUGINS_DIR/znap
source $PLUGINS_DIR/znap/znap.zsh # Start Znap

# znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

znap clone zsh-users/zsh-completions

fpath=(~[zsh-users/zsh-completions]/src $fpath)
#endregion Plugins

export SHELL="/bin/zsh"
export DOTFILES="$HOME/.dotfiles"
export GOPATH="$HOME/dev/go"
export NODE_COMPILE_CACHE="$HOME/.cache/node-cache"

#region Paths
# bun completions
source-config bun

MISE_BIN="$HOME/.local/share/mise/shims"
DOTNET_BIN="$HOME/.dotnet/tools"
CARGO_BIN="$HOME/.cargo/bin"
export PATH="$HOME/.local/bin:$CARGO_BIN:$GOPATH/bin:$BUN_BIN:$DOTNET_TOOLS:$MISE_BIN:$PATH"
#endregion Paths

if [[ $(uname -r) == *"WSL"* ]]; then
  IS_WSL=true
else
  IS_WSL=false
fi

# Ensures that gpg uses my tty for the password prompt
export GPG_TTY=$TTY

#region Completions
source-config completions
#endregion Completions

export PATH="$PATH:$HOME/.pub-cache/bin"

source-config clip
source-config wsl
source-config commands

PATH="~/.console-ninja/.bin:$PATH"

source-config keybinds
source-config cow

end=$(date +%s%N)
duration="$((end - start))"
echo "Execution time was $((duration / 1000000)) milliseconds"

znap prompt ohmyzsh/ohmyzsh
