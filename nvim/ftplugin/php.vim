setlocal textwidth=80
setlocal colorcolumn=121

" Include and gf file matching.
setlocal suffixesadd+=.php
setlocal includeexpr=substitute(v:fname,'^/','','')

" Colour column 81 only for PHP files in src/ or tests/.
autocmd BufEnter */{src,tests}/*.php setlocal colorcolumn=+1,121

" Configure ALE.
let b:ale_linters = ['php']

" Expand spaces and CRs in matching braces.
let b:delimitMate_expand_space = 1
let b:delimitMate_expand_cr = 1

" Jump to definition.
nmap <silent> <buffer> <C-]> <Plug>(coc-definition)

" Jump to definition in split.
nnoremap <silent> <buffer> <C-W>] :call CocAction('jumpDefinition', 'vsplit')<CR>
nnoremap <silent> <buffer> <C-W><C-]> :call CocAction('jumpDefinition', 'vsplit')<CR>

" Searching using ripgrep.
nnoremap <silent> <buffer> <Leader>sce :execute "Rg \\bclass .+ (extends\|implements) .*\\b" . expand("<cword>") . "\\b"<CR>
nnoremap <silent> <buffer> <Leader>sci :execute "Rg \\bnew\\s+" . expand("<cword>") . "\\b"<CR>
nnoremap <silent> <buffer> <Leader>scr :execute "Rg \\b" . expand("<cword>") . "::class\\b"<CR>
nnoremap <silent> <buffer> <Leader>smc :execute "Rg (->\|::)" . expand("<cword>") . "\\b"<CR>

" Phpactor
nnoremap <silent> <buffer> <Leader>u :call phpactor#UseAdd()<CR>
nnoremap <silent> <buffer> <Leader>e :call phpactor#ClassExpand()<CR>
nnoremap <silent> <buffer> <Leader>mm :call phpactor#ContextMenu()<CR>
nnoremap <silent> <buffer> <Leader>nn :call phpactor#Navigate()<CR>
nnoremap <silent> <buffer> <Leader>tt :call phpactor#Transform()<CR>
nnoremap <silent> <buffer> <Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
vnoremap <silent> <buffer> <Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
vnoremap <silent> <buffer> <Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

" PHP namespaces
nnoremap <silent> <buffer> <Leader>lu :call PhpInsertUse()<CR>
nnoremap <silent> <buffer> <Leader>le :call PhpExpandClass()<CR>
nnoremap <silent> <buffer> <Leader>su :call PhpSortUse()<CR>

" PDV
nnoremap <silent> <buffer> <Leader>ac :call pdv#DocumentWithSnip()<CR>
