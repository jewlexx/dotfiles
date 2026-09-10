source /usr/share/cachyos-fish-config/cachyos-config.fish

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

