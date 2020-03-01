" Jump to definition.
nmap <silent> <buffer> <C-]> <Plug>(coc-definition)

" Jump to definition in split.
nnoremap <silent> <buffer> <C-W>] :call CocAction('jumpDefinition', 'vsplit')<CR>
nnoremap <silent> <buffer> <C-W><C-]> :call CocAction('jumpDefinition', 'vsplit')<CR>
