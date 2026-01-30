#shellcheck source=none
source "$HOME/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}"

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

bindkey "${key[Home]}" beginning-of-line
bindkey "${key[End]}" end-of-line
bindkey "${key[Delete]}" delete-char