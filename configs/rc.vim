command! -nargs=0 EditConfig :edit ~/.dotfiles/configs/rc.vim

call plug#begin()
Plug 'junegunn/vim-easy-align'

Plug 'junegunn/vim-github-dashboard'

Plug 'hood/popui.nvim'
call plug#end()
