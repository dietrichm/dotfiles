if exists('g:loaded_python_path')
    finish
endif

let g:loaded_python_path = 1
let s:packages = ''

if !empty($VIRTUAL_ENV)
    let s:packages = glob('$VIRTUAL_ENV/lib/python*/site-packages')
elseif !empty($CONDA_PREFIX)
    let s:packages = glob('$CONDA_PREFIX/lib/python*/site-packages')
endif

if empty(s:packages)
    finish
endif

let &path .= ',' . s:packages

command! -bang -nargs=* Rgp call fzf#vim#grep(
    \ 'rg --column --line-number --no-heading --color=always --smart-case -- ' . shellescape(<q-args>),
    \ 1,
    \ call('fzf#vim#with_preview', [{'dir': s:packages}] + g:fzf_preview_window),
    \ <bang>0
\ )
