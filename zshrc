if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Init variables
export GPG_TTY=$(tty)
export SHELL="/bin/zsh"
export DOTFILES="$HOME/dotfiles"
export TOOLS="$HOME/Tools"
export ZSH="$HOME/.oh-my-zsh"
export DENO_INSTALL="$HOME/.deno"
export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:$DENO_INSTALL/bin:$HOME/bin:$HOME/spicetify-cli:$TOOLS/bin:/usr/local/go/bin:$HOME/.pub-cache/bin:$HOME/.local/bin"
export SDKMAN_DIR="$HOME/.sdkman"
export CHROME_EXECUTABLE="google-chrome-stable"

source $DOTFILES/commands.zsh
source $DOTFILES/antigen.zsh

antigen use oh-my-zsh
antigen theme romkatv/powerlevel10k
antigen bundle git
antigen bundle yarn
antigen bundle sudo
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
