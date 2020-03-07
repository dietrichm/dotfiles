setlocal spell

augroup markdown
    autocmd!
    " Disable spellcheck for API Blueprint files.
    autocmd BufEnter *.apib setlocal nospell
augroup END
