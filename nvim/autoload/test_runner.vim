function! s:GetConfig(key, default) abort
    let l:buffer_settings = get(b:, 'test_runner_settings', {})
    let l:Buffer_value = get(l:buffer_settings, a:key, '')

    if !empty(l:Buffer_value)
        return l:Buffer_value
    endif

    let l:global_settings = get(g:, 'test_runner_settings', {})
    let l:global_ft_settings = get(l:global_settings, &filetype, {})
    let l:Global_value = get(l:global_ft_settings, a:key, '')

    if !empty(l:Global_value)
        return l:Global_value
    endif

    return a:default
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
