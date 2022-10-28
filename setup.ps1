function local:createSymbolic([string]$source, [string]$target) {
    if (Test-Path $target) {
        Remove-Item $target
    }

    New-Item -Type symboliclink -Target $source -Path $target
}

$DOTFILES = "$HOME/.dotfiles"

createSymbolic "$DOTFILES/configs/git.win.properties" "$HOME/.gitconfig"
createSymbolic "$DOTFILES/configs/vimrc.vim" "$HOME/.vimrc"
createSymbolic "$DOTFILES/configs/init.vim" "$HOME/.config/nvim/init.vim"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
Invoke-RestMethod get.scoop.sh | Invoke-Expression

scoop bucket add java
scoop bucket add extras
scoop bucket add emulators "https://github.com/hermanjustnu/scoop-emulators.git"
scoop bucket add games
scoop bucket add personal "https://github.com/jewlexx/personal-scoop.git"

foreach ($line in Get-Content installed-scoop.txt) {
    scoop install $line
}