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

echo "Starting full system upgrade..."
echo "This may take a while..."

sudo pacman -Syu base-devel zip unzip --noconfirm

if ! [ $(command -v git) ]; then
    echo "Installing git"
    sudo pacman -S --noconfirm git
fi

if ! [ $(command -v curl) ]; then
    echo "No curl?"
    sudo pacman -S --noconfirm curl
fi

if ! [ $(command - v sdk) ]; then
    curl -s "https://get.sdkman.io" | bash
fi

sdk install 17.0.1-open

if ! [ $(command -v zsh) ]; then
    sudo pacman -S --noconfirm zsh
    chsh -s $(which zsh)
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing yay for AUR packages"
sudo pacman -S --noconfirm yay

if ! [ $(command -v node) ]; then
    echo "Installing NVM (Node Version Manager)"
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
fi

echo "Setting up node ersions"
nvm install node
nvm install --lts
nvm use node
nvm alias default node

sudo ln -s /var/lib/snapd/snap /snap

if ! [ $(command -v snap) ]; then
    echo "Installing snap"
    git clone https://aur.archlinux.org/snapd.git
    cd snapd
    makepkg -si

    sudo systemctl enable --now snapd.socket

    cd ..
    rm -rf snapd
fi

echo "Installing basic snap apps"
snap install code --classic

yay -S spotify

if ! [ $(command -v spicetify) ]; then
    yay -S spicetify-cli
fi

if ! [ $(command -v google-chrome-stable) ]; then
    yay -S google-chrome --noconfirm
fi

if ! [ $(command -v rustup) ]; then
    echo "Installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
