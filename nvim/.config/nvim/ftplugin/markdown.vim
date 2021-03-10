setlocal spell
setlocal foldlevel=1
compiler markdown

" Wrap visual selection in link.
vmap <silent> <buffer> <Leader>cl <Plug>VSurround]%a(
