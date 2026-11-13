# force clear homebrew locks
function brew-unlock
  rm -rf "$(brew --prefix)/var/homebrew/locks"
end