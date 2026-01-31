znap fpath _rustup 'rustup completions zsh'
znap fpath _cargo 'rustup completions zsh cargo'
znap fpath _deno 'deno completions zsh'

znap eval zoxide 'zoxide init zsh'
# znap eval mise 'mise activate zsh'
znap eval starship 'starship init zsh --print-full-init'