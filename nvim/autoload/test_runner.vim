function! s:GetConfig(key, default) abort
    return get(b:, 'test_runner_' . a:key, a:default)
endfunction

function! s:PrepareCommand(executable, file) abort
    let l:Transformer = s:GetConfig('filename_transformer', {file -> file})
    let l:command = substitute(a:executable, '{file}', l:Transformer(a:file), 'g')

    return l:command
endfunction

function! test_runner#RunCase() abort
    let l:executable = s:GetConfig('executable_case', '')

    if empty(l:executable)
        echomsg 'No case executable configured.'
        return
    endif

    let l:command = s:PrepareCommand(l:executable, bufname('%'))

    call VimuxRunCommand(l:command)
endfunction

function! test_runner#RunTest() abort
    let l:executable = s:GetConfig('executable_test', '')
    let l:test_name = get(b:, 'coc_current_function', '')

    if empty(l:executable)
        echomsg 'No test executable configured.'
        return
    endif

    if empty(l:test_name)
        echomsg 'No function found under cursor.'
        return
    endif

    let l:command = s:PrepareCommand(l:executable, bufname('%'))
    let l:command = substitute(l:command, '{test}', l:test_name, 'g')

    call VimuxRunCommand(l:command)
endfunction

function! test_runner#ReRun() abort
    call VimuxRunLastCommand()
endfunction
