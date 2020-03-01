" Expand spaces and CRs in matching braces.
let b:delimitMate_expand_space = 1
let b:delimitMate_expand_cr = 1

" Jump to definition.
nmap <silent> <buffer> <C-]> <Plug>(coc-definition)

" Jump to definition in split.
nnoremap <silent> <buffer> <C-W>] :call CocAction('jumpDefinition', 'vsplit')<CR>
nnoremap <silent> <buffer> <C-W><C-]> :call CocAction('jumpDefinition', 'vsplit')<CR>

" Commands provided by vim-go.
nmap <silent> <buffer> <Leader>gb <Plug>(go-build)
nmap <silent> <buffer> <Leader>gc <Plug>(go-coverage-toggle)
nmap <silent> <buffer> <Leader>gr <Plug>(go-run)
nmap <silent> <buffer> <Leader>gt <Plug>(go-test)

" Import word under cursor.
nnoremap <silent> <buffer> <Leader>u :execute "GoImport " . expand("<cword>")<CR>
