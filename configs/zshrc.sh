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
  asdf
  nvm
  sudo
  git
)

ZSH_THEME="powerlevel10k/powerlevel10k"

source $HOME/.asdf/asdf.sh
source $HOME/.dotfiles/utils/vars.sh
source $DOTFILES/utils/commands.sh
source $ZSH/oh-my-zsh.sh


# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k

# Setup Java home variable
. ~/.asdf/plugins/java/set-java-home.zsh

# Wasmer
export WASMER_DIR="$HOME/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /usr/share/zsh/functions/cmd-not-found.zsh

