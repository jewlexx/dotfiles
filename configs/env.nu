# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

$env.STARSHIP_CONFIG = $"($env.HOME)/.dotfiles/configs/starship.toml"
$env.DOTFILES = "$HOME/.dotfiles"
$env.ZSH = "$HOME/.oh-my-zsh"
$env.SHELL = "/bin/zsh"
$env.GOPATH = $"(go env GOPATH)"
