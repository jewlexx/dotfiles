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

foreach ($line in Get-Content scoop-buckets.txt) {
    scoop bucket add $line
}

foreach ($line in Get-Content scoop-packages.txt) {
    scoop install $line
}

Install-Module ps2exe -AllowClobber -AcceptLicense -Force