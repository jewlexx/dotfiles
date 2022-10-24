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

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
Invoke-RestMethod get.scoop.sh | Invoke-Expression

scoop bucket add java
scoop bucket add extras
scoop bucket add emulators
scoop bucket add games
scoop bucket add personal "https://github.com/jewlexx/personal-scoop.git"

scoop install `
    7zip `
    adb `
    android-sdk `
    android-studio `
    archwsl `
    audacity `
    bitwarden `
    dark `
    delta `
    dos2unix `
    dotnet-sdk `
    ds4windows `
    ffmpeg `
    flutter `
    gh `
    git `
    go `
    gpg4win `
    gsudo `
    handbrake `
    ignoreit `
    jetbrains-toolbox `
    lapce `
    livesplit `
    msys2 `
    multimc `
    neovim `
    obsidian `
    oha `
    polymc `
    python `
    ripgrep `
    rust-msvc `
    ryujinx `
    scoop-search `
    sd-card-formatter `
    starship `
    tokei `
    trash-cli `
    ungoogled-chromium `
    vcpkg `
    vcredist2013 `
    vcredist2022 `
    volta `
    which `
    youtube-dl