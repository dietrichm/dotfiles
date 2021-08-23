let g:PaperColor_Theme_Options = {
    \ 'theme': {
        \ 'default': {
            \ 'allow_bold': 1,
            \ 'allow_italic': 1,
        \ }
    \ }
\ }

" Colours
set background=light
try
    colorscheme PaperColor
catch /^Vim\%((\a\+)\)\=:E185/
endtry
