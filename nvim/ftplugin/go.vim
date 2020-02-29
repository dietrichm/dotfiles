" Commands provided by vim-go.
nmap <silent> <buffer> <Leader>gb <Plug>(go-build)
nmap <silent> <buffer> <Leader>gc <Plug>(go-coverage-toggle)
nmap <silent> <buffer> <Leader>gr <Plug>(go-run)
nmap <silent> <buffer> <Leader>gt <Plug>(go-test)

" Import word under cursor.
nnoremap <silent> <buffer> <Leader>u :execute "GoImport " . expand("<cword>")<CR>
