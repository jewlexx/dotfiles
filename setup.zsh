source $HOME/.dotfiles/utils/vars.zsh

git submodule init && git submodule update

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sh -c `curl -fsSL https://get.sdkman.io`

export NVM_DIR="`[ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm"`"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install --lts
nvm alias default --lts
npm i -g yarn typescript ts-node npkill

cd ~

export DOTFILES="$HOME/.dotfiles"

rm ~/.zshrc -f
rm ~/.p10k.zsh -f
rm ~/.gitconfig -f
rm ~/.config/alacritty/alacritty.yml -f

ln -s $DOTFILES/configs/rc.zsh ~/.zshrc
ln -s $DOTFILES/configs/p10k.zsh ~/.p10k.zsh
ln -s $DOTFILES/configs/git.properties ~/.gitconfig
ln -s $DOTFILES/configs/alacritty.yml ~/.config/alacritty/alacritty.yml  

FONTS_DIR="$HOME/.local/share/fonts"

sudo cp $DOTFILES/fonts/*/*.ttf $FONTS_DIR/
