command! -nargs=0 EditConfig :edit ~/.dotfiles/configs/rc.vim
command! -nargs=0 Reload :source ~/.dotfiles/configs/rc.vim

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'tpope/vim-sensible'

Plug 'junegunn/vim-easy-align'
Plug 'luochen1990/rainbow'
Plug 'junegunn/vim-github-dashboard'
Plug 'hrsh7th/nvim-cmp'

"" Rust Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'

"" GoLang Plugins
Plug 'fatih/vim-go'

"" UI Plugins
Plug 'RishabhRD/popfix'
Plug 'hood/popui.nvim'

call plug#end()

nnoremap ,d :lua require'popui.diagnostics-navigator'()<CR>

lua << EOF
require("rust-tools").setup({})

vim.ui.select = require("popui.ui-overrider")
vim.ui.input = require("popui.input-overrider")

EOF
