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

