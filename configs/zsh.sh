# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
#!/bin/bash

start=$(date +%s%N)

# shellcheck source=/dev/null
source <(zoxide init zsh)

# shellcheck source=/dev/null
source <(/usr/bin/starship init zsh --print-full-init)

# shellcheck source=/dev/null
source <(thefuck --alias)

export plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  sudo
)

if command -v sfsu.exe >/dev/null; then
  source <(sfsu.exe hook --shell zsh)
fi

if command -v google-chrome-stable >/dev/null; then
  export CHROME_EXECUTABLE="google-chrome-stable"
else
  export CHROME_EXECUTABLE="chromium"
fi

if [[ $(uname -r) == *"WSL"* ]]; then
  IS_WSL=true
else
  IS_WSL=false
fi

#region Variables
export DOTFILES="$HOME/.dotfiles"
export ZSH="$HOME/.oh-my-zsh"
export SHELL="/bin/zsh"
export GOPATH="$(go env GOPATH)"

# Paths
export PATH="$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.0.0/bin:$HOME/bin:$HOME/spicetify-cli:$HOME/.tools/bin:$HOME/.cargo/bin:$GOPATH/bin:$PATH"

# Ensures that gpg uses my tty for the password prompt
export GPG_TTY=$TTY

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
#endregion Variables

# shellcheck source=/dev/null
source "$ZSH/oh-my-zsh.sh"

# Initialize bash completions
autoload bashcompinit && bashcompinit

# Initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Wasmer
export WASMER_DIR="$HOME/.wasmer"
# shellcheck source=/dev/null
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

export DISPLAY=":0.0"
if $IS_WSL; then
  alias clip="clip.exe"

  export BROWSER="wslview"
  export LIBGL_ALWAYS_INDIRECT=1
else
  # Windows esque clip command
  alias clip="xclip -selection clipboard"
fi

# A little handler I wrote to handle command not found exceptions that looks them up
# in the pacman database
NOTFOUNDFILE="$DOTFILES/utils/cmd-not-found.sh"

if [ -f "$NOTFOUNDFILE" ]; then
  # shellcheck source=../utils/cmd-not-found.sh
  source "$NOTFOUNDFILE"
fi

export PATH="/opt/android-sdk/cmdline-tools/latest/bin/:$PATH"
export PATH="$PATH:$HOME/.pub-cache/bin"

#region Commands
# alias sudo="doas"
# Aliases
# Reload zshrc
alias rzsh="source ~/.zshrc"
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
# Use bat cuz cool
alias cat="bat"
# Replace exa with ls
alias l='exa'
alias la='exa -a'
alias ll='exa -lah'
alias ls='exa --color=auto'

# Alias native Linux commands to faster, modern alternatives
alias cp="xcp"
alias cd="z"
alias find="fd"
# alias ps="procs"
alias top="btm"
alias du="dust"
# Use tealdeer
alias man="tldr"

# Other tools I use:
## bandwhich, grex

# Seperated from init as I usually am not using conda
function init_conda {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/home/juliette/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "/home/juliette/miniconda3/etc/profile.d/conda.sh" ]; then
      . "/home/juliette/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="/home/juliette/miniconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
}

function create-pyexec {
  mkdir "$1"
  touch "$1/__main__.py"
}

function paru_opt {
  paru -S --asdeps --needed "$(paru -Si $1 | sed -n '/^Opt/,/^Conf/p' | sed '$d' | sed 's/^Opt.*://g' | sed 's/^\s*//g' | tr '\n' ' ')"
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

  cme -m "$1"
}

# Restart plasma
function rplasma {
  kquitapp5 plasmashell
  kstart5 plasmashell
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

# Compile and run a C program
function rcc {
  gcc "$1"
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
#endregion Commands

end=$(date +%s%N)

duration="$((end - start))"

echo "Execution time was $((duration / 1000000)) milliseconds"

# pnpm
export PNPM_HOME="/home/juliette/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

# bun completions
[ -s "/home/juliette/.bun/_bun" ] && source "/home/juliette/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ~/.dotfiles/wsl/WSLHostPatcher.exe
