" Colours
set background=dark
try
    colorscheme base16-bright
catch /^Vim\%((\a\+)\)\=:E185/
endtry

" Wrong spell words have black text.
highlight SpellBad ctermfg=0
highlight SpellLocal ctermfg=0
highlight SpellCap ctermfg=0
highlight SpellRare ctermfg=0

" Increase contrast in Golang coverage colours.
highlight goCoverageCovered ctermfg=lightcyan
highlight goCoverageUncover ctermfg=red
