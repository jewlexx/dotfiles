def cm [message: string] {
    git commit -S -a -m $message
}

def mkcd [dir: path] {
    mkdir $dir
    cd $dir
}

def rmrf [path: path] {
    rm -rf $path
}

def greet [name] {
    $"hello ($name)"
}

use ~/.cache/starship/init.nu

source ~/.cache/sfsu.nu
source ~/.zoxide.nu

alias ls = exa
alias ll = ls -l
alias la = ls -la
alias l = ls -lAh

alias cd = z
