source $HOME/.dotfiles/utils/vars.zsh

git submodule init && git submodule update

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
sh -c `curl -fsSL https://get.sdkman.io`
sh -c `curl -fsSL https://sh.rustup.rs`

source $HOME/.asdf/asdf.sh

rustup install stable
rustup install nightly

# Install nodejs
asdf plugin add nodejs
asdf install nodejs lts
asdf global nodejs lts

# Other plugins
asdf plugin add ruby
asdf plugin add deno

cd $HOME

export DOTFILES="$HOME/.dotfiles"

rm $HOME/.zshrc -f
rm $HOME/.p10k.zsh -f
rm $HOME/.gitconfig -f
rm $HOME/.config/alacritty/alacritty.yml -f
rm $HOME/.default-npm-packages

ln -s $DOTFILES/configs/rc.zsh $HOME/.zshrc
ln -s $DOTFILES/configs/p10k.zsh $HOME/.p10k.zsh
ln -s $DOTFILES/configs/git.properties $HOME/.gitconfig
ln -s $DOTFILES/configs/alacritty.yml $HOME/.config/alacritty/alacritty.yml  
ln -s $DOTFILES/configs/default-npm $HOME/.default-npm-packages

sudo cp $DOTFILES/fonts/*/*.ttf $HOME/.local/share/fonts
