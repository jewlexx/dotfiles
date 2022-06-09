command! -nargs=0 EditConfig edit ~/.vimrc
command! -nargs=0 Reload source ~/.vimrc

command! -nargs=1 SetTab call SetTab(<f-args>)
