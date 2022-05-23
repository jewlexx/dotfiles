#!/bin/bash

if command -v apt &>/dev/null; then
    if ! command -v code &>/dev/null; then
        snap install code --classic
    fi

    sudo apt-get update
    sudo apt-get upgrade -y

    sudo apt-get install build-essential -y
fi

curl https://sh.rustup.rs -sSf | sh -s -- -y

rustup install nightly
rustup default stable

cargo install cargo-edit
cargo install ignoreit
