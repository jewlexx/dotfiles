## Aliases
# Signs and commits in git with two chars
alias cm="git commit -Sam"
# Lil alias to reload zshrc
alias rzsh="source ~/.zshrc"
# Clip alias similar to windows
alias clip="xclip -selection clipboard"
# Alias to pull and push from git in one line
alias pp="git pull && git push"
# An alias for rm $1 -rf to make it slightly easier to force delete files/directories
alias rmrf="rm $1 -rf"
# A couple aliases to allow me to easily listen to my microphone
alias miclisten="pactl load-module module-loopback"
alias micstop="pactl unload-module module-loopback"
alias rpp="g++ $1 && ./a.out"
alias rp="gcc $1 && ./a.out"

function bs {
  clear;
  if [ -z "$1" ]; then
    echo "$1";
    genact;
  else
    genact -m $1;
  fi
}

# A function to make the directory and cd into it
function mkcd {
  mkdir -p "$1" && cd "$1"
}

# Alias to open file explorer
function explorer {
  if command -v "explorer.exe" > /dev/null
  then
    explorer.exe .
  else
    xdg-open .
  fi
}