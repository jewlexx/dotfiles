#!/bin/bash
rm $HOME/.zshrc $HOME/.gitconfig $HOME/.p10k.zsh -f

export DOTFILES="$HOME/dotfiles"

ln -s $DOTFILES/zshrc $HOME/.zshrc
ln -s $DOTFILES/p10k.zsh $HOME/.p10k.zsh
ln -s $DOTFILES/gitconfig $HOME/.gitconfig

DS_INFO=$(cat /etc/*-release | grep "^ID=" | cut -d "=" -f 2)

if [ "$DS_INFO" != "manjaro" ]; then
    if ["$DS_INFO" != "arch"]; then
        echo "This script is only for Arch Linux, and by extension, Manjaro Linux"
        exit 1
    fi
fi

if [ $EUID -ne 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

echo "Starting full system upgrade..."
echo "This may take a while..."

pacman -Syu --noconfirm

if ! [ $(command -v zsh) ]; then
    pacman -S --noconfirm zsh
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    chsh -s $(which zsh)
fi

if ! [ $(command -v git) ]; then
    echo "Installing git"
    pacman -S --noconfirm git
fi

if ! [ $(command -v curl) ]; then
    echo "No curl?"
    pacman -S --noconfirm curl
fi

echo "Installing yay for AUR packages"
pacman -S --noconfirm yay

if ! [ $(command -v node) ]; then
    echo "Installing NVM (Node Version Manager)"
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
fi

echo "Setting up node ersions"
nvm install node
nvm install --lts
nvm use node
nvm alias default node

if ! [ $(command -v snap) ]; then
    echo "Installing snap"
    git clone https://aur.archlinux.org/snapd.git
    cd snapd
    makepkg -si

    systemctl enable --now snapd.socket

    ln -s /var/lib/snapd/snap /snap

    cd ..
    rm -rf snapd
fi

echo "Installing basic snap apps"
snap install code --classic
snap install spotify

if ! [ $(command -v rustup) ]; then
    echo "Installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

yay -S google-chrome-stable --noconfirm