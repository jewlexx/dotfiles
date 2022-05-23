#!/bin/bash

if command -v apt &>/dev/null; then
    if ! command -v code &>/dev/null; then
        snap install code --classic
    fi

    sudo apt-get update
    sudo apt-get upgrade -y

    sudo apt-get install build-essential zsh -y
fi

curl -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh" | sh
curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh" | sh
curl -fsSL "https://sh.rustup.rs" | sh -s -- -y
curl -fsSL "https://rustwasm.github.io/wasm-pack/installer/init.sh" | sudo sh

source $HOME/.cargo/env

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

rustup install nightly
rustup default stable

cargo install cargo-edit
cargo install ignoreit
