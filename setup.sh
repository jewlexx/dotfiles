sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
sudo pacman -S code base-devel nvidia p7zip git

code --install-extension Shan.code-settings-sync

g++ `pwd`/src/main.cpp
./a.out

sh -c `curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh`
sh -c `curl -fsSL https://get.sdkman.io`
sh -c `curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh`

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install --lts

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cd ~

rm ~/.zshrc
rm ~/.gitconfig
rm ~/.p10k.zsh

ln -S ~/.zshrc ~/dotfiles/zshrc
ln -S ~/.gitconfig ~/dotfiles/gitconfig
ln -S ~/.p10k.zsh ~/dotfiles/p10k.zsh

cd dotfiles