command! -nargs=0 EditConfig :edit ~/.dotfiles/configs/rc.vim

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'junegunn/vim-easy-align'

Plug 'junegunn/vim-github-dashboard'

Plug 'hood/popui.nvim'
call plug#end()
