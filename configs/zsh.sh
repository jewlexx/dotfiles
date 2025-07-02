#!/bin/bash
start=$(date +%s%N)

unsetopt MULTIBYTE

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

znap install zsh-users/zsh-completions
#endregion Plugins

#region Variables
if [[ $(uname -r) == *"WSL"* ]]; then
  IS_WSL=true
else
  IS_WSL=false
fi

export DOTFILES="$HOME/.dotfiles"
# export ZSH="$HOME/.oh-my-zsh"
export SHELL="/bin/zsh"
export GOPATH="$(go env GOPATH)"
export NODE_COMPILE_CACHE="$HOME/.cache/node-cache"
export ANDROID_HOME="$HOME/Android/Sdk"

# Ensures that gpg uses my tty for the password prompt
export GPG_TTY=$TTY

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
#endregion Variables

#region Completions
znap fpath _rustup 'rustup completions zsh'
znap fpath _cargo 'rustup completions zsh cargo'
znap fpath _deno 'deno completions zsh'

# shellcheck source=/dev/null
znap eval zoxide 'zoxide init zsh'

# shellcheck source=/dev/null
znap eval starship 'starship init zsh --print-full-init'

if command -v sfsu.exe >/dev/null; then
  znap eval 'sfsu.exe hook --shell zsh'
fi
#endregion Completions

if $IS_WSL; then
  alias clip="clip.exe"

  export BROWSER="wslview"
  export LIBGL_ALWAYS_INDIRECT=1
else
  alias clip="wl-copy"
fi

# A little handler I wrote to handle command not found exceptions that looks them up
# in the pacman database
NOTFOUNDFILE="$DOTFILES/utils/cmd-not-found.sh"

if [ -f "$NOTFOUNDFILE" ]; then
  # shellcheck source=../utils/cmd-not-found.sh
  source "$NOTFOUNDFILE"
fi

export PATH="$PATH:$HOME/.pub-cache/bin"

if [ -d "$HOME/Tools" ]; then
  export PATH="$PATH:$HOME/Tools/bin"
fi

#region Commands
# alias sudo="doas"
# Aliases
# Reload zshrc
alias rzsh="source ~/.zshrc"
# An alias for rm $1 -rf to make it slightly easier to force delete files/directories
alias rmrf="rm -rfv"
alias rmr="rm -rv"
# A couple aliases to allow me to easily listen to my microphone
alias miclisten="pactl load-module module-loopback"
alias micstop="pactl unload-module module-loopback"
# Commit and sign and open editor to create message
alias cme="git commit -S -a"
alias cat="bat"
alias l='eza'
alias la='eza -a'
alias ll='eza -lah'
alias ls='eza --color=auto'
alias cp="xcp"
alias cd="z"
alias top="btm"
alias du="dust"

# Other tools I use:
## bandwhich, grex

# Seperated from init as I usually am not using conda
function init_conda {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
      . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="$HOME/miniconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
}

# Commit and sign without editor
function cm {
  if [ -z "$1" ]; then
    echo "Please provide a commit message"
    return 1
  fi

  if [ ${#1} -gt 72 ]; then
    echo "Commit message is too long"
    return 1
  fi

  git commit -S -a -m "$1"
}

# Bullshit generator
function bs {
  clear
  if [ -z "$1" ]; then
    echo "$1"
    genact
  else
    genact -m "$1"
  fi
}

# A function to make the directory and cd into it
function mkcd {
  mkdir -p "$1"
  cd "$1" || exit
}

function pull-gitignore {
  curl --output .gitignore -L "https://www.toptal.com/developers/gitignore/api/$@"
}

# Alias to open file explorer
if $IS_WSL; then
  alias explorer="wslview"
  alias xdg-open="wslview"
else
  alias explorer="xdg-open"
fi

# Set the monitor volume (not sure if this will work on any system other than my own)
function monitor-volume {
  sudo ddcutil --bus=7 setvcp 62 "$1"
}

# Generate pkg sums for a PKGBUILD file
function gen-pkg-sums {
  updpkgsums
}

function archive-dir {
  zip -9 -r "$1.zip" $1

  rm -rfv $1
}

alias cal="rusti-cal --color --starting-day 1 --week-numbers"
#endregion Commands

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export BUN_BIN="$BUN_INSTALL/bin"

if $IS_WSL; then
  if [ -f "$HOME/.dotfiles/wsl/WSLHostPatcher.exe" ]; then
    echo "Patching WSL host file..."
    "$HOME/.dotfiles/wsl/WSLHostPatcher.exe"
  else
    echo "WSLHostPatcher.exe not found, skipping patching."
  fi
fi

PATH="~/.console-ninja/.bin:$PATH"

# Paths
export DOTNET_TOOLS="$HOME/.dotnet/tools"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$GOPATH/bin:$HOME/Tools/bin:$BUN_BIN:$DOTNET_TOOLS:$PATH"

if [ -e /home/juliette/.nix-profile/etc/profile.d/nix.sh ]; then . /home/juliette/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

PATH=~/.console-ninja/.bin:$PATH

#region Keybindings
#shellcheck source=none
source "$HOME/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}"

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

bindkey "${key[Home]}" beginning-of-line
bindkey "${key[End]}" end-of-line
bindkey "${key[Delete]}" delete-char
#endregion Keybindings

end=$(date +%s%N)
duration="$((end - start))"
echo "Execution time was $((duration / 1000000)) milliseconds"

znap prompt ohmyzsh/ohmyzsh