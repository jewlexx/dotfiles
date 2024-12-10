# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

$env.HOME = "~"
$env.STARSHIP_CONFIG = $"($env.HOME)/.dotfiles/configs/starship.toml"
$env.DOTFILES = $"($env.HOME)/.dotfiles"
$env.ZSH = $"($env.HOME)/.oh-my-zsh"
$env.SHELL = "/bin/zsh"
$env.GOPATH = $"(go env GOPATH)"
