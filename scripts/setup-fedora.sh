#!/bin/bash

OLD_PWD=$(pwd)

sudo dnf install zsh rustup -y

rustup-init -y --profile default --default-toolchain stable --default-host x86_64-unknown-linux-gnu
# shellcheck source=/dev/null
source "$HOME/.cargo/env"
echo "Installed Rustup"

echo "Installing Rust packages"
cargo install xcp --locked
echo "Installed Rust packages"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

# Install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh - | bash >/dev/null
# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' >/dev/null

sudo dnf install -y tealdeer bat dotnet-sdk-8.0 pass eza zoxide

DOTFILES=$(pwd)

rm "$HOME/.zshrc" -f
rm "$HOME/.gitconfig" -f
rm "$HOME/.config/alacritty/alacritty.toml" -f
rm "$HOME/.config/starship.toml" -f
rm "$HOME/.default-npm-packages" -f
rm "$HOME/.config/nvim/init.vim" -f
rm "$HOME/.vimrc" -f
rm "$HOME/.tool-versions" -f

mkdir "$HOME/.config/alacritty" -p
mkdir "$HOME/.config/nvim" -p
mkdir "$HOME/.cache/starship" -p

starship init nu >"$HOME/.cache/starship/init.nu"

ln -s "$DOTFILES/configs/zsh.sh" "$HOME/.zshrc"
ln -s "$DOTFILES/configs/p10k.sh" "$HOME/.p10k.zsh"
ln -s "$DOTFILES/configs/git.nix.properties" "$HOME/.gitconfig"
ln -s "$DOTFILES/configs/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
ln -s "$DOTFILES/configs/starship.toml" "$HOME/.config/starship.toml"
ln -s "$DOTFILES/configs/default-npm" "$HOME/.default-npm-packages"
ln -s "$DOTFILES/configs/vimrc.vim" "$HOME/.vimrc"
ln -s "$DOTFILES/configs/init.vim" "$HOME/.config/nvim/init.vim"
ln -s "$DOTFILES/configs/config.nu" "$HOME/.config/config.nu"
ln -s "$DOTFILES/configs/env.nu" "$HOME/.config/env.nu"
ln -s "$DOTFILES/configs/tools.txt" "$HOME/.tool-versions"
