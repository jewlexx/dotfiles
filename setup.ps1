function local:Test-Version {
    $Major = $Host.Version.Major

    if ($Major -lt 7) {
        throw "PowerShell 7.0 or higher is required"
    }
}

Test-Version

function local:New-Symbolic([string]$source, [string]$target) {
    if (Test-Path $target) {
        Remove-Item $target
    }

    New-Item -Type symboliclink -Target $source -Path $target
}

$DOTFILES = "$HOME/.dotfiles"

New-Symbolic "$DOTFILES/configs/git.win.properties" "$HOME/.gitconfig"
New-Symbolic "$DOTFILES/configs/vimrc.vim" "$HOME/.vimrc"
New-Symbolic "$DOTFILES/configs/init.vim" "$HOME/.config/nvim/init.vim"

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

Install-Module ps2exe -AllowClobber -AcceptLicense -Force