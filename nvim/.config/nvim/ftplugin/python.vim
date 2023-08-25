setlocal textwidth=79
setlocal colorcolumn=+1,100

" Searching using ripgrep.
nnoremap <silent> <buffer> <Leader>sce :execute "Rg \\bclass .+\\(.*\\b" . expand("<cword>") . "\\b.*\\)"<CR>
nnoremap <silent> <buffer> <Leader>sci :execute "Rg \\b" . expand("<cword>") . "\\("<CR>
nnoremap <silent> <buffer> <Leader>smc :execute "Rg \\." . expand("<cword>") . "\\b"<CR>
