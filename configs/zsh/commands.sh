eval "$(zoxide init zsh)"

#region Aliases
# alias sudo="doas"
# Aliases
# Reload zshrc
alias rzsh="source ~/.zshrc"
# An alias for rm $1 -rf to make it slightly easier to force delete files/directories
alias rmrf="rm -rfv"
alias rmr="rm -rv"
# Commit and sign and open editor to create message
alias cme="git commit -S -a"
alias cat="bat"
alias l='eza'
alias la='eza -a'
alias ll='eza -lah'
alias ls='eza --color=auto'
alias cp="xcp"
alias cd="z"
alias du="dust"
alias cal="rusti-cal --color --starting-day 1 --week-numbers"
#endregion Aliases

#region Functions
# force clear homebrew locks
function brew-unlock {
  rm -rf "$(brew --prefix)/var/homebrew/locks"
}

# Commit and sign without editor
function cm {
  if [ -z "$1" ]; then
    git commit -S -a
    #echo "Please provide a commit message"
    return 1
  fi

  if [ ${#1} -gt 72 ]; then
    echo "Commit message is too long"
    return 1
  fi

  git commit -S -a -m "$1"
}

# Bullshit generator
function bs {
  clear
  if [ -z "$1" ]; then
    echo "$1"
    genact
  else
    genact -m "$1"
  fi
}

# A function to make the directory and cd into it
function mkcd {
  mkdir -p "$1"
  cd "$1" || exit
}

function pull-gitignore {
  curl --output .gitignore -L "https://www.toptal.com/developers/gitignore/api/$@"
}

function archive-dir {
  zip -9 -r "$1.zip" $1

  rm -rfv $1
}
#endregion Functions

if [[ $OSTYPE == "linux-gnu"* ]]; then
    source-config linux-commands
fi
