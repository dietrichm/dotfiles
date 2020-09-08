setlocal spell
compiler markdown

" Wrap visual selection in link.
vmap <silent> <buffer> <Leader>cl <Plug>VSurround]%a(
