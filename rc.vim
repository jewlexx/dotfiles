call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
"" Copied from JDH - Need to go through
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vim-airline/vim-airline'
Plug 'wlangstroth/vim-racket'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/tagbar'
Plug 'universal-ctags/ctags'
Plug 'vim-syntastic/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tommcdo/vim-lion'
Plug 'Shirk/vim-gas'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'

Plug 'valloric/youcompleteme'

Plug 'preservim/nerdcommenter'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'sindrets/winshift.nvim'

Plug 'preservim/nerdtree'
Plug 'davidhalter/jedi-vim'

Plug 'tpope/vim-sensible'
Plug 'wbthomason/packer.nvim'
Plug 'L3MON4D3/LuaSnip'

"" Completions
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'junegunn/vim-easy-align'
Plug 'luochen1990/rainbow'
Plug 'junegunn/vim-github-dashboard'

"" Rust Plugins
Plug 'rust-lang/rust.vim'

"" GoLang Plugins
Plug 'fatih/vim-go'
call plug#end()

syntax enable
filetype plugin indent on

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Create default mappings
let g:NERDCreateDefaultMappings = 1
let g:rustfmt_autosave = 1
let g:rainbow_active = 1
let g:coc_node_path = "/home/juliette/.nvm/versions/node/v16.15.1/bin/node"

autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()

" Highlight the symbol and its references when holding the cursor.

autocmd CursorHold * silent call CocActionAsync('highlight')

" Get syntax files from config folder
set runtimepath+=~/.config/nvim/syntax

colorscheme palenight " gruvbox

" Syntax highlighting
syntax on

" Position in code
set number
set ruler

" default file encoding
set encoding=utf-8

" Line wrap
set wrap

" Highlight search results
set hlsearch
set incsearch

" auto + smart indent for code
set autoindent
set smartindent

""" Shortcuts
let mapleader = ";"

nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <silent> <leader>c} V}:call NERDComment('x', 'toggle')<CR>
nnoremap <silent> <leader>c{ V{:call NERDComment('x', 'toggle')<CR>

nnoremap <leader>s <Esc>:w<CR>
nnoremap <leader>ec :EditConfig<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader><f5> :Reload<CR>

" Open WinShift
nnoremap <leader>w :WinShift<CR>

" Move lines up and down
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

" Switch between tabs
nnoremap <silent> <A-Left> :tabprevious<CR>
nnoremap <silent> <A-Right> :tabnext<CR>

" Disable C-z from job-controlling neovim
nnoremap <c-z> <nop>

" Untab with Shift-Tab
nnoremap <S-Tab> <C-d>

" nnoremap <c-q> :close<CR>

nmap <leader>p :GFiles<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap C-c to <esc>
nmap <c-c> <esc>
imap <c-c> <esc>

vmap <c-c> <esc>
omap <c-c> <esc>

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

""" Functions
command! -nargs=0 EditConfig edit ~/.vimrc
command! -nargs=0 Reload source ~/.vimrc

command! -nargs=1 SetTab call SetTab(<f-args>)

" Function to set tab width to n spaces
function! SetTab(n)
    let &l:tabstop=a:n
    let &l:softtabstop=a:n
    let &l:shiftwidth=a:n
    set expandtab
endfunction


lua << EOF
require("winshift").setup({
  highlight_moving_win = true,  -- Highlight the window being moved
  focused_hl_group = "Visual",  -- The highlight group used for the moving window
  moving_win_options = {
    -- These are local options applied to the moving window while it's
    -- being moved. They are unset when you leave Win-Move mode.
    wrap = false,
    cursorline = false,
    cursorcolumn = false,
    colorcolumn = "",
  },
  -- The window picker is used to select a window while swapping windows with
  -- ':WinShift swap'.
  -- A string of chars used as identifiers by the window picker.
  window_picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
  window_picker_ignore = {
    -- This table allows you to indicate to the window picker that a window
    -- should be ignored if its buffer matches any of the following criteria.
    filetype = {  -- List of ignored file types
      "NvimTree",
    },
    buftype = {   -- List of ignored buftypes
      "terminal",
      "quickfix",
    },
    bufname = {   -- List of regex patterns matching ignored buffer names
      [[.*foo/bar/baz\.qux]]
    },
  },
})
EOF

" Mouse support
set mouse=a

" no delays!
set updatetime=300

set completeopt=menu,menuone,noselect

