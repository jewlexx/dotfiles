function local:Test-Version
{
    $Major = $Host.Version.Major

    if ($Major -lt 7)
    {
        Write-Output 'Installing Powershell 7'

        scoop install powershell
    }
}

function local:New-Symbolic([string]$source, [string]$target)
{
    if (Test-Path $target)
    {
        Remove-Item $target
    }

    New-Item -Type symboliclink -Target $source -Path $target
}

Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    New-Item $HOME/vimfiles/autoload/plug.vim -Force

$DOTFILES = "$HOME/.dotfiles"

New-Symbolic "$DOTFILES/configs/git.win.properties" "$HOME/.gitconfig"
New-Symbolic "$DOTFILES/configs/vimrc.vim" "$HOME/.vimrc"

# Ensure nvim location exists
New-Item "$HOME/AppData/Local/nvim" -Type Directory
New-Symbolic "$DOTFILES/configs/init.vim" "$HOME/AppData/Local/nvim/init.vim"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
Invoke-RestMethod get.scoop.sh | Invoke-Expression

Test-Version

scoop import $DOTFILES/scoop-export.json

Install-Module ps2exe -AllowClobber -AcceptLicense -Force
