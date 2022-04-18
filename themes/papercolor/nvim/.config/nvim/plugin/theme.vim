let g:PaperColor_Theme_Options = {
    \ 'theme': {
        \ 'default': {
            \ 'transparent_background': 1,
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

hi SignColumn guibg=NONE
hi TelescopeMatching gui=bold,underline
