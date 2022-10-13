#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)"

# Install rustup
echo "Installing Rustup"
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable --profile default &>/dev/null

source $HOME/.cargo/env

rustup install stable
rustup install nightly
echo "Installed Rustup"

# Install wasm-pack
curl -fsSL "https://rustwasm.github.io/wasm-pack/installer/init.sh" | sh &>/dev/null
# Install volta
curl -fsSL "https://get.volta.sh" | sh &>/dev/null
# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' &>/dev/null

HAS_GUI=$DISPLAY
OLD_PWD=$(pwd)

if [ command pacman ]; then
  sudo pacman -S zsh rust-analyzer --noconfirm

  mkdir /tmp
  cd /tmp
  sudo pacman -S --needed git base-devel --noconfirm && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si
  cd $OLD_PWD
fi

paru -S --noconfirm gum

source $HOME/.dotfiles/utils/vars.sh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

DOTFILES=$(pwd)

rm $HOME/.zshrc -f
rm $HOME/.p10k.zsh -f
rm $HOME/.gitconfig -f
rm $HOME/.config/alacritty/alacritty.yml -f
rm $HOME/.default-npm-packages -f
rm $HOME/.config/nvim/init.vim -f
rm $HOME/.vimrc -f

mkdir $HOME/.config/alacritty -p
mkdir $HOME/.config/nvim -p

ln -s $DOTFILES/zshrc $HOME/.zshrc
ln -s $DOTFILES/configs/p10k.sh $HOME/.p10k.zsh
ln -s $DOTFILES/configs/git.nix.properties $HOME/.gitconfig
ln -s $DOTFILES/configs/alacritty.yml $HOME/.config/alacritty/alacritty.yml
ln -s $DOTFILES/configs/default-npm $HOME/.default-npm-packages
ln -s $DOTFILES/configs/vimrc.vim $HOME/.vimrc
ln -s $DOTFILES/configs/init.vim $HOME/.config/nvim/init.vim

if -n $HAS_GUI; then
  # Sometimes fails and I don't really care so ignore the output
  mkdir -p $HOME/.local/share/fonts
  cp $DOTFILES/fonts/*/*.ttf $HOME/.local/share/fonts &>/dev/null
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install NodeJS
volta install node node@latest pnpm yarn
