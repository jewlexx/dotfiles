# Aliases
# Reload zshrc
alias rzsh="source ~/.zshrc"
# Windows esque clip command
alias clip="xclip -selection clipboard"
# An alias for rm $1 -rf to make it slightly easier to force delete files/directories
alias rmrf="rm -rf $1"
alias rmr="rm -r $1"
# A couple aliases to allow me to easily listen to my microphone
alias miclisten="pactl load-module module-loopback"
alias micstop="pactl unload-module module-loopback"
# VSCode aliases
alias code.="code ."
alias codedot="code $DOTFILES"

# Commit and sign in git
function cm {
  # Not really sure why it FEELS THE NEED to only work when I do this but yk
  COMMAND="git commit -S -am '$@'"
  sh -c "$COMMAND"
}

function rplasma {
  kquitapp5 plasmashell &> /dev/null || killall plasmashell && kstart5 plasmashell &> /dev/null
}

function bs {
  clear
  if [ -z "$1" ]; then
    echo "$1"
    genact
  else
    genact -m $1
  fi
}

function rcc {
  gcc $1
  # This includes all the args except for the file name
  ./a.out ${@:2}
}

function rpp {
  g++ $1
  # This includes all the args except for the file name
  ./a.out ${@:2}
}

# A function to make the directory and cd into it
function mkcd {
  mkdir -p "$1"
  cd "$1"
}

# Alias to open file explorer
# uses explorer.exe if it exists because often I am using WSL on my laptop
function explorer {
  if command -v "explorer.exe" >/dev/null; then
    explorer.exe $1
  else
    xdg-open $1
  fi
}

function monitor-volume {
  sudo ddcutil --bus=7 setvcp 62 $1
}

function show-switch {
  sudo ddcutil --bus=7 setvcp 60 04
}

function gen-pkg-sums {
  updpkgsums
}