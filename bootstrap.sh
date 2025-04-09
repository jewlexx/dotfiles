#!/bin/bash
# Note that this script is particularly designed for Github Codespaces

OLD_PWD=$(pwd)

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "Installed Rust"

git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

git -C ~/.oh-my-zsh/custom/plugins clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git
git -C ~/.oh-my-zsh/custom/plugins clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git
git -C ~/.oh-my-zsh/custom/themes clone --depth=1 https://github.com/romkatv/powerlevel10k.git

# Install bun
curl -fsSL https://bun.sh/install | bash

# Install starship
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y

# Install deno
curl -fsSL https://deno.land/install.sh | sh -s -- -y

# Install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Install eza repository
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

sudo apt-get update
sudo apt-get install -y bat python3-dev python3-pip python3-setuptools gpg eza

DOTFILES=$(pwd)

rm "$HOME/.zshrc" -f
rm "$HOME/.config/starship.toml" -f
rm "$HOME/.default-npm-packages" -f

mkdir "$HOME/.cache/starship" -p

ln -s "$DOTFILES/configs/zsh.sh" "$HOME/.zshrc"
ln -s "$DOTFILES/configs/p10k.sh" "$HOME/.p10k.zsh"
ln -s "$DOTFILES/configs/starship.toml" "$HOME/.config/starship.toml"

sudo chsh -s $(which zsh) $(whoami)