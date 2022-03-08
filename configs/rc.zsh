# Init variables
## Forces terminal to be English
export LC_ALL=C
export GPG_TTY=$(tty)
export SHELL="/bin/zsh"
export DOTFILES="$HOME/dotfiles"
export TOOLS="$HOME/Tools"
export ZSH="$HOME/.oh-my-zsh"
export DENO_INSTALL="$HOME/.deno"
export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:$DENO_INSTALL/bin:$HOME/bin:$HOME/spicetify-cli:$TOOLS/bin:/usr/local/go/bin:$HOME/.pub-cache/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.dotnet"
export SDKMAN_DIR="$HOME/.sdkman"
export CHROME_EXECUTABLE="google-chrome-stable"
export STARSHIP_CONFIG="$HOME/dotfiles/configs/starship.toml"

source $DOTFILES/utils/commands.zsh
source $ZSH/oh-my-zsh.sh

plugins=(
  yarn
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  sudo
)

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(starship init zsh)"