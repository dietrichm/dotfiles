setlocal textwidth=79
setlocal colorcolumn=+1

let b:ale_python_auto_pipenv = 1

" Configure test runner.
let b:test_runner_executable = 'pipenv run pytest'
let b:test_runner_filter_arg = '-k '

call ApplyCocDefinitionMappings()
