sh -C $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)
sh -C `curl -fsSL https://get.sdkman.io`
sh -C `curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh`

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install node
nvm alias default node

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cd ~

rm ~/.zshrc -f
rm ~/.gitconfig -f
rm ~/.p10k.zsh -f

ln -s ~/.zshrc ~/dotfiles/zshrc
ln -s ~/.gitconfig ~/dotfiles/gitconfig
ln -s ~/.p10k.zsh ~/dotfiles/p10k.zsh