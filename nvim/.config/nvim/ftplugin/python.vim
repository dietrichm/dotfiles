setlocal textwidth=79
setlocal colorcolumn=+1,100

let b:ale_python_flake8_change_directory = 0
let b:delimitMate_expand_cr = 1
let b:delimitMate_expand_space = 1

nnoremap <silent> <buffer> <Leader>so :ALEFix isort<CR>

" Searching using ripgrep.
nnoremap <silent> <buffer> <Leader>sce :execute "Rg \\bclass .+\\(.*\\b" . expand("<cword>") . "\\b.*\\)"<CR>
nnoremap <silent> <buffer> <Leader>sci :execute "Rg \\b" . expand("<cword>") . "\\("<CR>
nnoremap <silent> <buffer> <Leader>smc :execute "Rg \\." . expand("<cword>") . "\\b"<CR>
