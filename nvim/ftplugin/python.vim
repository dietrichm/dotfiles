setlocal textwidth=79
setlocal colorcolumn=+1,100

let b:ale_python_auto_pipenv = 1
let b:ale_python_flake8_change_directory = 0
let b:delimitMate_expand_cr = 1
let b:delimitMate_expand_space = 1

if !empty(findfile('Pipfile.lock', '.;'))
    let b:test_runner_executable_case = 'pipenv run pytest {file}'
    let b:test_runner_executable_test = 'pipenv run pytest {file} -k {test}'
endif

call ApplyCocDefinitionMappings()

nnoremap <silent> <buffer> <Leader>si :ALEFix isort<CR>

" Searching using ripgrep.
nnoremap <silent> <buffer> <Leader>sce :execute "Rg \\bclass .+\\(.*\\b" . expand("<cword>") . "\\b.*\\)"<CR>
nnoremap <silent> <buffer> <Leader>sci :execute "Rg \\b" . expand("<cword>") . "\\("<CR>
nnoremap <silent> <buffer> <Leader>smc :execute "Rg \\." . expand("<cword>") . "\\b"<CR>
