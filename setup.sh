curl -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh" | sh
curl -fsSL "https://sh.rustup.rs" | sh
curl -fsSL "https://rustwasm.github.io/wasm-pack/installer/init.sh" | sudo sh
curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh" | sh

if ![ command -v "zsh" ]; then
    if command -v "apt"; then
        sudo apt install zsh
    elif command -v "pacman"; then
        sudo pacman -S zsh
    else
        echo "Unable to install zsh. Please use Debian or Arch Linux."
    fi

    chsh -s $(which zsh)
fi

source $HOME/.dotfiles/utils/vars.zsh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0

source $HOME/.cargo/env
source $HOME/.asdf/asdf.sh

rustup install stable
rustup install nightly

cargo install cargo-edit --feature vendored-openssl
cargo install cargo-watch
cargo install --force cargo-make

cd $HOME

rm $HOME/.zshrc -f
rm $HOME/.p10k.zsh -f
rm $HOME/.gitconfig -f
rm $HOME/.config/alacritty/alacritty.yml -f
rm $HOME/.default-npm-packages -f

ln -s $DOTFILES/configs/rc.zsh $HOME/.zshrc
ln -s $DOTFILES/configs/p10k.zsh $HOME/.p10k.zsh
ln -s $DOTFILES/configs/git.properties $HOME/.gitconfig
ln -s $DOTFILES/configs/alacritty.yml $HOME/.config/alacritty/alacritty.yml
ln -s $DOTFILES/configs/default-npm $HOME/.default-npm-packages

sudo cp $DOTFILES/fonts/*/*.ttf $HOME/.local/share/fonts

# Install asdf plugins
asdf plugin add java
asdf plugin add ruby
asdf plugin add deno
asdf plugin add flutter
asdf plugin add dart
asdf plugin add golang

# Install Java
asdf install java adoptopenjdk-17.0.2+8
asdf global java adoptopenjdk-17.0.2+8

# Install deno
asdf install deno latest
asdf global deno latest

# Install NodeJS
nvm install --lts
nvm install node
nvm alias default --lts
