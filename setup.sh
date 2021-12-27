# #!/bin/bash
# rm $HOME/.zshrc $HOME/.gitconfig $HOME/.p10k.zsh -f

# export DOTFILES="$HOME/dotfiles"

# ln -s $DOTFILES/zshrc $HOME/.zshrc
# ln -s $DOTFILES/p10k.zsh $HOME/.p10k.zsh
# ln -s $DOTFILES/gitconfig $HOME/.gitconfig

# DS_INFO=$(cat /etc/*-release | grep "^ID=" | cut -d "=" -f 2)

# if [ "$DS_INFO" != "manjaro" ]; then
#     if ["$DS_INFO" != "arch"]; then
#         echo "This script is only for Arch Linux, and by extension, Manjaro Linux"
#         exit 1
#     fi
# fi

# echo "Starting full system upgrade..."
# echo "This may take a while..."

# sudo pacman -Syu base-devel zip unzip yay git curl zsh --noconfirm
# chsh -s $(which zsh)

# if ! [ $(command - v sdk) ]; then
#     curl -s "https://get.sdkman.io" | bash
# fi

# sdk install java 17.0.1-open

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# if ! [ $(command -v node) ]; then
#     echo "Installing NVM (Node Version Manager)"
#     curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
# fi

# echo "Setting up node ersions"
# nvm install --lts
# nvm install node
# nvm use --lts

# sudo ln -s /var/lib/snapd/snap /snap

# if ! [ $(command -v snap) ]; then
#     echo "Installing snap"
#     git clone https://aur.archlinux.org/snapd.git
#     cd snapd
#     makepkg -si

#     sudo systemctl enable --now snapd.socket

#     cd ..
#     rm -rf snapd
# fi

# echo "Installing basic snap apps"
# snap install code --classic

# yay -S spotify
# yay -S spicetify-cli
# yay -S google-chrome --removemake --nodiffmenu --noupgrademenu --noeditmenu --nodiffaur --noupgradear

sudo pacman -Syu rust rust-wasm rust-bindgen cargo --noconfirm

cargo run