setlocal textwidth=80
setlocal colorcolumn=121

" Include and gf file matching.
setlocal includeexpr=substitute(v:fname,'^/','','')

augroup php
    autocmd!
    " Colour column 81 only for PHP source files and tests.
    autocmd BufEnter */{app,domain,src,tests}/*.php setlocal colorcolumn=+1,121
augroup END
