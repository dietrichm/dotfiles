function! test_runner#Run(current_test) abort
    let l:executable = get(b:, 'test_runner_executable', '')
    let l:filter_arg = get(b:, 'test_runner_filter_arg', '')
    let l:current_test_name = get(b:, 'coc_current_function', '')

    if empty(l:executable)
        echomsg 'No executable configured.'
        return
    endif

    let l:command = l:executable . ' ' . bufname('%')

    if a:current_test == v:false
        call VimuxRunCommand(l:command)
        return
    endif

    if empty(l:filter_arg)
        echomsg 'No filter argument configured.'
        return
    endif

    if empty(l:current_test_name)
        echomsg 'No function found under cursor.'
        return
    endif

    let l:command .= ' ' . l:filter_arg . l:current_test_name

    call VimuxRunCommand(l:command)
endfunction

function! test_runner#RunCase() abort
    call test_runner#Run(v:false)
endfunction

function! test_runner#RunTest() abort
    call test_runner#Run(v:true)
endfunction
