export GPG_TTY=$(tty)
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

export PATH="$DENO_INSTALL/bin:$HOME/bin:$HOME/spicetify-cli:$HOMEApplications/7z:$PATH"

# Set the zsh theme to p10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Init plugins
plugins=(
  git
  yarn
  zsh-autosuggestions
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
alias gpp="git pull && git push"

alias npmg="npm i -g"

alias mman="man man"

alias codezsh="code $HOME/dotfiles/zshrc"

# A function to make the directory and cd into it
function mkcd {
  mkdir -p "$1" && cd "$1"
}

export GPG_TTY=$(tty)
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export CHROME_EXECUTABLE="google-chrome-stable"

source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
