function local:createSymbolic([string]$source, [string]$target) {
    if (Test-Path $target) {
        Remove-Item $target
    }

    New-Item -Type symboliclink -Target $source -Path $target
}

createSymbolic "$HOME\.dotfiles\configs\git.win.properties" "$HOME\.gitconfig"