#!/bin/bash

if command -v apt &>/dev/null; then
    if ! command -v code &>/dev/null; then
        snap install code --classic
    fi

    sudo apt-get update
    sudo apt-get upgrade -y

    sudo apt-get install build-essential zsh -y
fi

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

curl https://sh.rustup.rs -sSf | sh -s -- -y

rustup install nightly
rustup default stable

cargo install cargo-edit
cargo install ignoreit
