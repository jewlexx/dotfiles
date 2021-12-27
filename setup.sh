#!/bin/bash
rm $HOME/.zshrc $HOME/.gitconfig $HOME/.p10k.zsh -f

ln -s $HOME/dotfiles/zshrc $HOME/.zshrc && ln -s $HOME/dotfiles/p10k.zsh $HOME/.p10k.zsh && ln -s $HOME/dotfiles/gitconfig $HOME/.gitconfig