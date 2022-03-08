plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  yarn
  sudo
  git
)

source $HOME/dotfiles/utils/vars.zsh
source $DOTFILES/utils/commands.zsh
source $ZSH/oh-my-zsh.sh

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval `starship init zsh`