# Some initial p10k setup
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Init variables
export ZSH="$HOME/.oh-my-zsh"
export DENO_INSTALL="$HOME/.deno"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$DENO_INSTALL/bin:$PATH"

# Set the zsh theme to p10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Init plugins
plugins=(git yarn)

# Init oh-my-zsh
source $ZSH/oh-my-zsh.sh

## Aliases
# Signs and commits in git with two chars
alias cm="git commit -S -a -m"
# Lil alias to reload zshrc
alias rzsh="source ~/.zshrc"
# Clip alias similar to windows
alias clip="xclip -selection clipboard"

# A function to make the directory and cd into it
function mkcd {
  mkdir -p "$1" && cd "$1"
}

# Init p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh