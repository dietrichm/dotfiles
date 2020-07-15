setlocal textwidth=79
setlocal colorcolumn=+1
setlocal formatexpr=CocAction('formatSelected')

let b:ale_python_auto_pipenv = 1
let b:ale_python_flake8_change_directory = 0
let b:delimitMate_expand_cr = 1
let b:delimitMate_expand_space = 1

" Configure test runner.
let b:test_runner_executable = 'pipenv run pytest'
let b:test_runner_filter_arg = '-k '

call ApplyCocDefinitionMappings()

nmap <silent> <buffer> <Leader>rn <Plug>(coc-rename)
nnoremap <silent> <buffer> <Leader>si :call CocAction('runCommand', 'python.sortImports')<CR>

" Searching using ripgrep.
nnoremap <silent> <buffer> <Leader>sce :execute "Rg \\bclass .+\\(.*\\b" . expand("<cword>") . "\\b.*\\)"<CR>
nnoremap <silent> <buffer> <Leader>sci :execute "Rg \\b" . expand("<cword>") . "\\("<CR>
nnoremap <silent> <buffer> <Leader>smc :execute "Rg \\." . expand("<cword>") . "\\b"<CR>
