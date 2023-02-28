#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)"

# Install volta
curl -fsSL "https://get.volta.sh" | bash >/dev/null
# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' >/dev/null

HAS_GUI=$DISPLAY
OLD_PWD=$(pwd)

if command pacman; then
  sudo pacman -S zsh rustup --noconfirm

  rustup install stable
  rustup install nightly
  echo "Installed Rustup"

  mkdir /tmp
  cd /tmp || exit
  sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si
  cd "$OLD_PWD" || exit
fi

# shellcheck source=/dev/null
source "$HOME/.cargo/env"

paru -Sy --noconfirm gum tealdeer bat asp devtools bottom base-devel git git-credential-manager-core-bin gnome-keyring pass dust grex bandwhich procs fd xcp

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

DOTFILES=$(pwd)

rm "$HOME/.zshrc" -f
rm "$HOME/.gitconfig" -f
rm "$HOME/.config/alacritty/alacritty.yml" -f
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
ln -s "$DOTFILES/configs/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
ln -s "$DOTFILES/configs/starship.toml" "$HOME/.config/starship.toml"
ln -s "$DOTFILES/configs/default-npm" "$HOME/.default-npm-packages"
ln -s "$DOTFILES/configs/vimrc.vim" "$HOME/.vimrc"
ln -s "$DOTFILES/configs/init.vim" "$HOME/.config/nvim/init.vim"
ln -s "$DOTFILES/configs/config.nu" "$HOME/.config/nushell/config.nu"
ln -s "$DOTFILES/configs/env.nu" "$HOME/.config/nushell/env.nu"
ln -s "$DOTFILES/configs/tools.txt" "$HOME/.tool-versions"

if [ -n "$HAS_GUI" ]; then
  # Sometimes fails and I don't really care so ignore the output
  mkdir -p "$HOME/.local/share/fonts"
  cp "$DOTFILES/fonts/*/*.ttf" "$HOME/.local/share/fonts" &>/dev/null
fi

# Ensure Volta in path for volta setup
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Install NodeJS
volta install node node@latest pnpm yarn zx
