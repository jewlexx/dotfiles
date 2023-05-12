set encoding=utf-8

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'wakatime/vim-wakatime'

Plug 'vim-airline/vim-airline'
Plug 'wlangstroth/vim-racket'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/tagbar'
Plug 'universal-ctags/ctags'
Plug 'vim-syntastic/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'Shirk/vim-gas'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-fugitive'

Plug 'startup-nvim/startup.nvim'

" File explorer
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

"" NOTE: Does not work on WSL2
" Plug 'andweeb/presence.nvim'

let g:coc_global_extensions = ['coc-zig', 'coc-tabnine', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-rust-analyzer', 'coc-pairs', 'coc-spell-checker', 'coc-highlight', '@yaegassy/coc-volar', 'coc-clangd']

" Completions
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Themes
Plug 'morhetz/gruvbox'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'dracula/vim'
Plug 'olimorris/onedarkpro.nvim'

" Syntax
Plug 'pangloss/vim-javascript'
Plug 'cespare/vim-toml'
Plug 'vim-syntastic/syntastic'

" Language Tools

Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'
Plug 'vim-crystal/vim-crystal'

" Debugging
Plug 'mfussenegger/nvim-dap'

Plug 'dense-analysis/ale'

Plug 'neovim/nvim-lspconfig'
Plug 'fatih/vim-go'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'vhdirk/vim-cmake'

Plug 'preservim/nerdcommenter'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'jvgrootveld/telescope-zoxide'

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

Plug 'sindrets/winshift.nvim'

Plug 'davidhalter/jedi-vim'

Plug 'tpope/vim-sensible'

Plug 'junegunn/vim-easy-align'
Plug 'luochen1990/rainbow'
Plug 'junegunn/vim-github-dashboard'
call plug#end()

syntax enable
filetype plugin indent on

colorscheme gruvbox

" Mouse support
set mouse=a

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

" Automaticaly close nvim if NERDTree is only thing left open
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd BufWritePre <buffer> lua vim.lsp.buf.format()

" Highlight the symbol and its references when holding the cursor.

autocmd CursorHold * silent call CocActionAsync('highlight')

" Format JSON using jq on save
"
autocmd FileType json set formatprg=jq

" Get syntax files from config folder
set runtimepath+=~/.config/nvim/syntax

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

map <C-n> :NERDTree<CR>
map <C-t> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>

map <esc><esc> <Esc>:noh<CR>

nmap <silent> <leader>c} V}:call NERDComment('x', 'toggle')<CR>
nmap <silent> <leader>c{ V{:call NERDComment('x', 'toggle')<CR>

nmap <leader><Esc> <Esc>:q<CR>
nmap <leader>s <Esc>:w<CR>
nmap <leader>ec :EditConfig<CR>
nmap <leader>n :NERDTreeFocus<CR>
nmap <leader><f5> :Reload<CR>

" Open WinShift
nmap <leader>w :WinShift<CR>

" Move lines up and down
map <silent> <A-j> :m .+1<CR>==
map <silent> <A-k> :m .-2<CR>==

" Switch between tabs
map <silent> <A-Left> :tabprevious<CR>
map <silent> <A-Right> :tabnext<CR>

" Terminal Keybinds
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction

map <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <c-t> :call OpenTerminal()<CR>

" Disable C-z from job-controlling neovim
nnoremap <c-z> <nop>

" Unindent with Shift-Tab
map <S-Tab> <C-d>

" nnoremap <c-q> :close<CR>

" Telescope fuzzy finder commands
nmap <leader>p <cmd>Telescope find_files<CR>
nmap <leader>g <cmd>Telescope live_grep<CR>
nmap <leader>b <cmd>Telescope buffers<CR>
nmap <leader>fh <cmd>Telescope help_tags<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap C-c to <esc>
map <c-c> <esc>

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

""" Functions
command! -nargs=0 EditConfig edit ~/.dotfiles/configs/vimrc.vim
command! -nargs=0 Reload source ~/.dotfiles/configs/vimrc.vim

command! -nargs=1 SetTab call SetTab(<f-args>)

" Function to set tab width to n spaces
function! SetTab(n)
    let &l:tabstop=a:n
    let &l:softtabstop=a:n
    let &l:shiftwidth=a:n
    set expandtab
endfunction

function! NewFile(path)
    execute 'edit' a:path
endfunction

" ale linting settings
let g:ale_linters = {
    \ 'vim': ['vint'],
    \ 'cpp': ['clang'],
    \ 'c': ['clang']
\}

" custom setting for clangformat
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4}"']
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']

" General options
" let g:presence_auto_update         = 1
" let g:presence_neovim_image_text   = "The One True Text Editor"
" let g:presence_main_image          = "neovim"
" let g:presence_client_id           = "793271441293967371"
" let g:presence_log_level           = "debug"
" let g:presence_debounce_timeout    = 10
" let g:presence_enable_line_number  = 0
" let g:presence_blacklist           = []
" let g:presence_buttons             = 1
" let g:presence_file_assets         = {}
" let g:presence_show_time           = 1
"
" " Rich Presence text options
" let g:presence_editing_text        = "Editing %s"
" let g:presence_file_explorer_text  = "Browsing %s"
" let g:presence_git_commit_text     = "Committing changes"
" let g:presence_plugin_manager_text = "Managing plugins"
" let g:presence_reading_text        = "Reading %s"
" let g:presence_workspace_text      = "Working on %s"
" let g:presence_line_number_text    = "Line %s out of %s"

lua << EOF
-- Startup Setup
require"startup".setup()

-- Winshift Setup
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
  picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
  picker_ignore = {
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

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
EOF

" no delays!
set updatetime=300

" set completeopt=menu,menuone,noselect

