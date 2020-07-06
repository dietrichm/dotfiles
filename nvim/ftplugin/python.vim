setlocal textwidth=79
setlocal colorcolumn=+1

let b:ale_python_auto_pipenv = 1
let b:ale_python_flake8_change_directory = 0

" Configure test runner.
let b:test_runner_executable = 'pipenv run pytest'
let b:test_runner_filter_arg = '-k '

call ApplyCocDefinitionMappings()

nmap <silent> <buffer> <Leader>rn <Plug>(coc-rename)
nnoremap <silent> <buffer> <Leader>si :call CocAction('runCommand', 'python.sortImports')<CR>
