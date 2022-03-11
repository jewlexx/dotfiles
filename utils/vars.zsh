# Init variables
## Forces terminal to be English
export LC_ALL=C
export GPG_TTY=`tty`
export SHELL="/bin/zsh"
export DOTFILES="$HOME/.dotfiles"
export TOOLS="$HOME/Tools"
export ZSH="$HOME/.oh-my-zsh"
export DENO_INSTALL="$HOME/.deno"
export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:$DENO_INSTALL/bin:$HOME/bin:$HOME/spicetify-cli:$TOOLS/bin:/usr/local/go/bin:$HOME/.pub-cache/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.dotnet:$HOME/.tools/bin"
export SDKMAN_DIR="$HOME/.sdkman"
export CHROME_EXECUTABLE="google-chrome-stable"
export STARSHIP_CONFIG="$DOTFILES/configs/starship.toml"
export NVM_DIR="$DOTFILES/nvm"