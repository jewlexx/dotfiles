export GPG_TTY=$(tty)
export SHELL="/bin/zsh"
export DOTFILES="$HOME/dotfiles"
export TOOLS="$HOME/Tools"

# Init p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Init variables
export ZSH="$HOME/.oh-my-zsh"
export DENO_INSTALL="$HOME/.deno"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$PATH:$DENO_INSTALL/bin:$HOME/bin:$HOME/spicetify-cli:$TOOLS/bin:/usr/local/go/bin:$HOME/.pub-cache/bin:$HOME/.local/bin"

# Set the zsh theme to p10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Init plugins
plugins=(
  git
  yarn
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Init oh-my-zsh
source $ZSH/oh-my-zsh.sh

## Aliases
# Signs and commits in git with two chars
alias cm="git commit -Sam"
# Lil alias to reload zshrc
alias rzsh="source ~/.zshrc"
# Clip alias similar to windows
alias clip="xclip -selection clipboard"
# Alias to pull and push from git in one line
alias pp="git pull && git push"
# An alias for rm $1 -rf to make it slightly easier to force delete files/directories
alias rmrf="rm $1 -rf"
# A couple aliases to allow me to easily listen to my microphone
alias miclisten="pactl load-module module-loopback"
alias micstop="pactl unload-module module-loopback"
alias rpp="g++ $1 && ./a.out"
alias rp="gcc $1 && ./a.out"

function bs {
  clear;
  if [ -z "$1" ]; then
    echo "$1";
    genact;
  else
    genact -m $1;
  fi
}

# A function to make the directory and cd into it
function mkcd {
  mkdir -p "$1" && cd "$1"
}

# Alias to open file explorer
function explorer {
  if command -v "explorer.exe" > /dev/null
  then
    explorer.exe .
  else
    xdg-open .
  fi
}

export CHROME_EXECUTABLE="google-chrome-stable"

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
