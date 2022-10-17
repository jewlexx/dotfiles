function local:createSymbolic([string]$source, [string]$target) {
    if (Test-Path $target) {
        Remove-Item $target
    }

    New-Item -Type symboliclink -Target $source -Path $target
}

createSymbolic "$DOTFILES/zshrc.sh" "$HOME/.zshrc"
createSymbolic "$DOTFILES/configs/p10k.sh" "$HOME/.p10k.zsh"
createSymbolic "$DOTFILES/configs/git.nix.properties" "$HOME/.gitconfig"
createSymbolic "$DOTFILES/configs/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
createSymbolic "$DOTFILES/configs/default-npm" "$HOME/.default-npm-packages"
createSymbolic "$DOTFILES/configs/vimrc.vim" "$HOME/.vimrc"
createSymbolic "$DOTFILES/configs/init.vim" "$HOME/.config/nvim/init.vim"