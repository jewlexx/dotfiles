    #!/bin/bash
curl -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh" | sh
curl -fsSL "https://sh.rustup.rs" | sh
curl -fsSL "https://rustwasm.github.io/wasm-pack/installer/init.sh" | sudo sh
curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh" | sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

OLD_PWD=`pwd`

mkdir /tmp
cd /tmp
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd $OLD_PWD

sudo pacman -S zsh rust-analyzer --noconfirm

source $HOME/.dotfiles/utils/vars.zsh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0

source $HOME/.cargo/env
source $HOME/.asdf/asdf.sh

rustup install stable
rustup install nightly

cargo install cargo-edit --features vendored-openssl
cargo install cargo-watch
cargo install --force cargo-make

cd $HOME

rm $HOME/.zshrc -f
rm $HOME/.p10k.zsh -f
rm $HOME/.gitconfig -f
rm $HOME/.config/alacritty/alacritty.yml -f
rm $HOME/.default-npm-packages -f
rm $HOME/.config/nvim/init.vim -f
rm $HOME/.vimrc -f
rm $HOME/.vim/*.vim -f

mkdir $HOME/.config/alacritty -p
mkdir $HOME/.config/nvim -p
mkdir $HOME/.vim -p

ln -s $DOTFILES/configs/rc.zsh $HOME/.zshrc
ln -s $DOTFILES/configs/p10k.zsh $HOME/.p10k.zsh
ln -s $DOTFILES/configs/git.properties $HOME/.gitconfig
ln -s $DOTFILES/configs/alacritty.yml $HOME/.config/alacritty/alacritty.yml
ln -s $DOTFILES/configs/default-npm $HOME/.default-npm-packages
ln -s $DOTFILES/rc.vim $HOME/.vimrc
ln -s $DOTFILES/init.vim $HOME/.config/nvim/init.vim
ln -s $DOTFILES/vim/* $HOME/.vim/

sudo cp $DOTFILES/fonts/*/*.ttf $HOME/.local/share/fonts

# Install asdf plugins
asdf plugin add java
asdf plugin add ruby
asdf plugin add deno
asdf plugin add flutter
asdf plugin add dart
asdf plugin add golang

# Install Java
asdf install java adoptopenjdk-17.0.2+8
asdf global java adoptopenjdk-17.0.2+8

# Install deno
asdf install deno latest
asdf global deno latest

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install NodeJS
nvm install --lts
nvm install node
nvm alias default --lts
