#!/bin/zsh
start=$(date +%s%N)

unsetopt MULTIBYTE

function source-config {
  source "$DOTFILES/configs/zsh/$1.sh"
}

# Homebrew LLVM
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export CMAKE_PREFIX_PATH="/opt/homebrew/opt/llvm"

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

export MISE_BIN="$HOME/.local/share/mise/shims"
export DOTNET_BIN="$HOME/.dotnet/tools"
export CARGO_BIN="$HOME/.cargo/bin"
export DENO_BIN="$HOME/.deno/bin"
export PATH="$HOME/.local/bin:$CARGO_BIN:$GOPATH/bin:$DENO_BIN:$BUN_BIN:$DOTNET_BIN:$MISE_BIN:$PATH"
if [[ $OSTYPE == "darwin"* ]]; then
  export PATH="/opt/homebrew/opt/ffmpeg-full/bin:$PATH"
fi
export PATH="$HOME/.pub-cache/bin:$PATH"
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

source-config clip
source-config wsl
source-config commands
source-config keybinds
source-config cow

end=$(date +%s%N)
duration="$((end - start))"
echo "Execution time was $((duration / 1000000)) milliseconds"

znap prompt ohmyzsh/ohmyzsh
export PATH="/Users/juliette/.splashkit:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/juliette/.lmstudio/bin"
# End of LM Studio CLI section

