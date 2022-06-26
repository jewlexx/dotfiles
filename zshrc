# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
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
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
  export LIBGL_ALWAYS_INDIRECT=1
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

#region Commands
# Aliases
# Reload zshrc
alias rzsh="source ~/.zshrc"
# Windows esque clip command
alias clip="xclip -selection clipboard"
# An alias for rm $1 -rf to make it slightly easier to force delete files/directories
alias rmrf="rm -rf $1"
alias rmr="rm -r $1"
# A couple aliases to allow me to easily listen to my microphone
alias miclisten="pactl load-module module-loopback"
alias micstop="pactl unload-module module-loopback"
# VSCode aliases
alias code.="code ."
alias codedot="code $DOTFILES"

# Commit and sign in git
function cm {
  # Not really sure why it FEELS THE NEED to only work when I do this but yk
  COMMAND="git commit -S -am '$@'"
  sh -c "$COMMAND"
}

function rplasma {
  kquitapp5 plasmashell &> /dev/null || killall plasmashell && kstart5 plasmashell &> /dev/null
}

function bs {
  clear
  if [ -z "$1" ]; then
    echo "$1"
    genact
  else
    genact -m $1
  fi
}

function rcc {
  gcc $1
  # This includes all the args except for the file name
  ./a.out ${@:2}
}

function rpp {
  g++ $1
  # This includes all the args except for the file name
  ./a.out ${@:2}
}

# A function to make the directory and cd into it
function mkcd {
  mkdir -p "$1"
  cd "$1"
}

# Alias to open file explorer
# uses explorer.exe if it exists because often I am using WSL on my laptop
function explorer {
  if command -v "explorer.exe" >/dev/null; then
    explorer.exe $1 > /dev/null
  else
    xdg-open $1 > /dev/null
  fi
}

function monitor-volume {
  sudo ddcutil --bus=7 setvcp 62 $1
}

function show-switch {
  sudo ddcutil --bus=7 setvcp 60 04
}

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

source $ZSH/oh-my-zsh.sh

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Wasmer
export WASMER_DIR="$HOME/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /usr/share/zsh/functions/cmd-not-found.zsh
