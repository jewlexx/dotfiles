#!/bin/bash

me=$(whoami)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
P10KP="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$me.zsh"
if [[ -r "$P10KP" ]]; then
  # shellcheck source=/dev/null
  source "$P10KP"
fi

export plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  yarn
  nvm
  sudo
  git
)

# Fixes issues with WSLg Arch configuration
if ! command -v wsl.exe &> /dev/null
then
  DISPLAY=$(grep nameserver < /etc/resolv.conf | awk '{print $2; exit;}'):0.0
  export DISPLAY
  export LIBGL_ALWAYS_INDIRECT=1
fi

export ZSH_THEME="powerlevel10k/powerlevel10k"

#region Commands
# Aliases
# Reload zshrc
alias rzsh="source ~/.zshrc"
# Windows esque clip command
alias clip="xclip -selection clipboard"
# An alias for rm $1 -rf to make it slightly easier to force delete files/directories
alias rmrf="rm -rf"
alias rmr="rm -r"
# A couple aliases to allow me to easily listen to my microphone
alias miclisten="pactl load-module module-loopback"
alias micstop="pactl unload-module module-loopback"
# Commit and sign and open editor to create message
alias cme="git commit -S -a"
# Ensure that "chromium" is available for Flutter to use
alias chromium="xdg-open"

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

  cme -m "$1"
}

# Restart plasma (deprecated)
function rplasma {
  kquitapp5 plasmashell &> /dev/null || killall plasmashell && kstart5 plasmashell &> /dev/null
}

# Bullshit generator
function bs {
  clear
  if [ -z "$1" ]; then
    echo "$1"
    genact
  else
    genact -m $1
  fi
}

# Compile and run a C program
function rcc {
  gcc $1
  # This includes all the args except for the file name
  # ShellCheck error disabled as that is the point
  # shellcheck disable=SC2068
  ./a.out ${@:2}
}

# Compile and run a C++ program
function rpp {
  g++ "$1"
  # This includes all the args except for the file name
  # ShellCheck error disabled as that is the point
  # shellcheck disable=SC2068
  ./a.out ${@:2}
}

# A function to make the directory and cd into it
function mkcd {
  mkdir -p "$1"
  cd "$1" || exit
}

# Alias to open file explorer
# uses explorer.exe if it exists because often I am using WSL on my laptop
function explorer {
  xdg-open "$1" > /dev/null
}

# Set the monitor volume
function monitor-volume {
  sudo ddcutil --bus=7 setvcp 62 "$1"
}

# Generate pkg sums for a PKGBUILD file
function gen-pkg-sums {
  updpkgsums
}
#endregion Commands

#region Variables
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
#endregion Variables

# shellcheck source=/dev/null
source $ZSH/oh-my-zsh.sh

# Initialize bash completions
autoload bashcompinit && bashcompinit

# Initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
# shellcheck source=/dev/null
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Wasmer
export WASMER_DIR="$HOME/.wasmer"
# shellcheck source=/dev/null
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

if [[ $(uname -r) == *"WSL"* ]]; then
  # Comment this line out if not using wsl
  export BROWSER="wslview"
fi

# A little handler I wrote to handle command not found exceptions that looks them up
# in the pacman database
NOTFOUNDFILE="$DOTFILES/utils/cmd-not-found.sh"

if [ -f "$NOTFOUNDFILE" ]; then
  # shellcheck source=/dev/null
  source "$NOTFOUNDFILE"
fi

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# shellcheck source=/dev/null
source <(volta completions zsh)

# Load Angular CLI autocompletion.
source <(ng completion script)

export PATH="/opt/android-sdk/cmdline-tools/latest/bin/:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"
