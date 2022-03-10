source $HOME/.dotfiles/utils/vars.zsh

git submodule init && git submodule update

sh -C `curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh`
sh -C `curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh`
sh -C `curl -fsSL https://get.sdkman.io`


curl -fsSL https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/CharlieS1103/spicetify-marketplace/main/install.sh | sh

export NVM_DIR="`[ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm"`"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install node
nvm alias default node
npm i -g yarn typescript ts-node npkill

cd ~

export DOTFILES="$HOME/.dotfiles"

rm ~/.zshrc -f
rm ~/.gitconfig -f
rm ~/.config/alacritty/alacritty.yml -f

ln -s $DOTFILES/configs/rc.zsh ~/.zshrc
ln -s $DOTFILES/configs/git.properties ~/.gitconfig
ln -s $DOTFILES/configs/alacritty.yml ~/.config/alacritty/alacritty.yml  

FONTS_DIR="$HOME/.local/share/fonts"

sudo cp $DOTFILES/fonts/*/*.ttf $FONTS_DIR/
