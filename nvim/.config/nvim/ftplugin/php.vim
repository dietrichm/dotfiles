setlocal textwidth=80
setlocal colorcolumn=121

" Include and gf file matching.
setlocal suffixesadd+=.php
setlocal includeexpr=substitute(v:fname,'^/','','')

augroup php
    autocmd!
    " Colour column 81 only for PHP source files and tests.
    autocmd BufEnter */{app,domain,src,tests}/*.php setlocal colorcolumn=+1,121
augroup END

" Expand spaces and CRs in matching braces.
let b:delimitMate_expand_space = 1
let b:delimitMate_expand_cr = 1

" Searching using ripgrep.
nnoremap <silent> <buffer> <Leader>sce :execute "Rg \\bclass .+ (extends\|implements) .*\\b" . expand("<cword>") . "\\b"<CR>
nnoremap <silent> <buffer> <Leader>sci :execute "Rg \\bnew\\s+" . expand("<cword>") . "\\b"<CR>
nnoremap <silent> <buffer> <Leader>scr :execute "Rg \\b" . expand("<cword>") . "::class\\b"<CR>
nnoremap <silent> <buffer> <Leader>smc :execute "Rg (->\|::)" . expand("<cword>") . "\\b"<CR>
