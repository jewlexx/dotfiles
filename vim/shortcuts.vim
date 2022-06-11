let mapleader = ";"

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <leader>ec :EditConfig<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader><f5> :Reload<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <silent> <leader>c} V}:call NERDComment('x', 'toggle')<CR>
nnoremap <silent> <leader>c{ V{:call NERDComment('x', 'toggle')<CR>

nnoremap <silent> <A-Left> :tabprevious<CR>
nnoremap <silent> <A-Right> :tabnext<CR>

" Disable C-z from job-controlling neovim
nnoremap <c-z> <nop>

inoremap <S-Tab> <C-d>
nnoremap <c-f5> :Reload<CR>

nnoremap <c-s> <Esc>:w<CR>
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
