rm $HOME/.zshrc $HOME/.gitconfig $HOME/.p10k.zsh -f

export DOTFILES="$HOME/dotfiles"

echo "source $DOTFILES/zshrc" >> $HOME/.zshrc
echo "source $DOTFILES/p10k.zsh" >> $HOME/.p10k.zsh

ln -s $HOME/dotfiles/gitconfig $HOME/.gitconfig
