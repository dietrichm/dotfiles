setlocal spell
setlocal foldlevel=1
compiler markdown

" Wrap visual selection in link.
vmap <silent> <buffer> <Leader>cl <Plug>VSurround]%a(

" Surround text with `*` places double asterisks.
let b:surround_42 = "**\r**"
