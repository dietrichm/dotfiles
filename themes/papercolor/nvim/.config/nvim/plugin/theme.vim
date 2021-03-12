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
colorscheme PaperColor

" Error messages have grey text.
highlight ErrorMsg ctermfg=0

" Suitable Semshi colours for light theme.
highlight semshiAttribute ctermfg=7
highlight semshiBuiltin ctermfg=11
highlight semshiGlobal ctermfg=11
highlight semshiImported ctermfg=11 cterm=bold
highlight semshiParameter ctermfg=3
highlight semshiParameterUnused ctermfg=3 cterm=underline
highlight semshiSelf ctermfg=8
highlight semshiUnresolved ctermfg=13 cterm=underline,italic