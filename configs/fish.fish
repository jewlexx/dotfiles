# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

function mkcd
	mkdir $argv
	cd $argv
end

zoxide init fish | source
mise activate fish | source
source (/usr/bin/starship init fish --print-full-init | psub)

alias cd="z"

# force clear homebrew locks
function brew-unlock
  rm -rf "$(brew --prefix)/var/homebrew/locks"
end