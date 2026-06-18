OLD_PWD=$(pwd)

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "Installed Rust"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)"

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' >/dev/null

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

sudo apt-get update
sudo apt-get install -y bat python3-dev python3-pip python3-setuptools zsh gpg

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install starship zoxide deno bun eza

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
ln -s "$DOTFILES/configs/vim" "$HOME/.config/nvim"

sudo chsh -s $(which zsh) $(whoami)