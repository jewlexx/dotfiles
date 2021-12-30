export GPG_TTY=$(tty)
export SHELL="/bin/zsh"
export DOTFILES=$HOME/dotfiles
export TOOLS=$HOME/Tools
export RUBY_BIN="/home/james/.local/share/gem/ruby/3.0.0/bin"

# Init p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# /home/james/.var/app/com.spotify.Client/config/spotify

# Init variables
export ZSH="$HOME/.oh-my-zsh"
export DENO_INSTALL="$HOME/.deno"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$PATH:$DENO_INSTALL/bin:$HOME/bin:$HOME/spicetify-cli:$TOOLS/bin:/usr/local/go/bin:$HOME/.pub-cache/bin:$RUBY_BIN"

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
alias cm="git commit -S -a -m"
# Lil alias to reload zshrc
alias rzsh="source ~/.zshrc"
# Clip alias similar to windows
alias clip="xclip -selection clipboard"
# Alias to open file explorer
alias files="xdg-open"
# Alias to see how much gpu usage we are sitting at
alias gpu="gpustat -i 1"
# Alias to pull and push from git in one line
alias pp="git pull && git push"
# Idk why but I thought this was funny
alias mman="man man"
# Makes it slightly easier to open my zshrc with vscode
alias codezsh="code $DOTFILES/zshrc"
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

function inityarn {
  yarn set version berry
  yarn plugin import interactive-tools
  yarn plugin import typescript
  yarn
}

function lndir {
  ln -s $(pwd)/$1 $2
}

export CHROME_EXECUTABLE="google-chrome-stable"

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
