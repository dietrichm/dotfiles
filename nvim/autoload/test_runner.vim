function! test_runner#Run() abort
    let l:executable = get(b:, 'test_runner_executable', '')

    if empty(l:executable)
        echomsg 'No executable configured.'
        return
    endif

    let l:command = l:executable . ' ' . bufname('%')

    call VimuxRunCommand(l:command)
endfunction
