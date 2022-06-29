Remove-Item "$HOME\.gitconfig" -Force
New-Item -Type symboliclink -Target "$HOME\.dotfiles\configs\git.win.properties" -Path "$HOME\.gitconfig"