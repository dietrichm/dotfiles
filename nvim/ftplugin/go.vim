" Expand spaces and CRs in matching braces.
let b:delimitMate_expand_space = 1
let b:delimitMate_expand_cr = 1

call ApplyCocDefinitionMappings()

" Commands provided by vim-go.
nmap <silent> <buffer> <Leader>gb <Plug>(go-build)
nmap <silent> <buffer> <Leader>gc <Plug>(go-coverage-toggle)
nmap <silent> <buffer> <Leader>gi <Plug>(go-imports)
nmap <silent> <buffer> <Leader>gr <Plug>(go-run)
nmap <silent> <buffer> <Leader>gt <Plug>(go-test)
nmap <silent> <buffer> <Leader>u <Plug>(go-import)
