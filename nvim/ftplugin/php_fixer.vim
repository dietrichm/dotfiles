function! AlePhpCsFixerTempFile(buffer) abort
    return bufname(a:buffer) . '.ale-php-cs-fixer'
endfunction

function! AlePhpCsFixer(buffer) abort
    let l:temporary_file = AlePhpCsFixerTempFile(a:buffer)
    let l:lines = getbufline(a:buffer, 1, '$')
    call ale#util#Writefile(a:buffer, l:lines, l:temporary_file)

    return {
        \ 'command': 'php-cs-fixer fix ' . shellescape(l:temporary_file),
        \ 'process_with': 'AleProcessPhpCsFixer',
        \ 'read_buffer': 0,
    \ }
endfunction

function! AleProcessPhpCsFixer(buffer, output) abort
    let l:temporary_file = AlePhpCsFixerTempFile(a:buffer)
    let l:lines = readfile(l:temporary_file)
    call delete(l:temporary_file)

    return l:lines
endfunction

let b:ale_fixers = ['AlePhpCsFixer']
