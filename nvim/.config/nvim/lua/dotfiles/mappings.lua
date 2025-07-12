local map = vim.keymap.set

-- map('ca', 'w;', 'w')
map('i', '<C-;>', [[<C-O>:call searchpair('(', '', ')')<CR><Right>]], { silent = true })
map('i', '<S-Tab>', '<Right>')
map('n', '#', [[:setlocal hlsearch | :normal! #<CR>]])
map('n', '*', [[:setlocal hlsearch | :normal! *<CR>]])
map('n', '<Leader>da', [[:%bd<CR>]])
map('n', '<Leader>m', [[:silent make %<CR>]], { silent = true })
map('n', '<Leader>pc', [[:let @+ = expand('%:.') | :echomsg "Copied:" @+<CR>]], { silent = true })
map('n', '<Leader>Pc', [[:let @+ = expand('%:p:~') | :echomsg "Copied:" @+<CR>]], { silent = true })
map('n', '<Leader>q', vim.diagnostic.setloclist)
map('n', '<Leader>rc', [[:noautocmd update | :TestFile<CR>]], { silent = true })
map('n', '<Leader>rr', [[:noautocmd update | :TestLast<CR>]], { silent = true })
map('n', '<Leader>rt', [[:noautocmd update | :TestNearest<CR>]], { silent = true })
map('n', '<Space>', '')
map('n', '\\', [[:setlocal hlsearch!<CR>]])
map('n', 'g#', [[:setlocal hlsearch | :normal! g#<CR>]])
map('n', 'g*', [[:setlocal hlsearch | :normal! g*<CR>]])
map('n', 'j', [[v:count == 0 && &ft != 'qf' ? 'gj' : 'j']], { expr = true })
map('n', 'k', [[v:count == 0 && &ft != 'qf' ? 'gk' : 'k']], { expr = true })
map('n', '{', [[:keepjumps normal! {<CR>]], { silent = true })
map('n', '}', [[:keepjumps normal! }<CR>]], { silent = true })
map('t', '<Esc>', [[<C-\><C-n>]])

map('n', 'q', function()
  return vim.bo.buftype == 'terminal' and ':bd<CR>' or 'q'
end, { expr = true, silent = true })

map('ia', 'rstr', function()
  return io.open('/dev/urandom'):read(500):gsub('[^%w]', ''):sub(0, 32)
end, { expr = true })

map('ia', 'rpwd', function()
  return io.open('/dev/urandom'):read(500):gsub('[^%w%p]', ''):sub(0, 32)
end, { expr = true })

map('ia', 'ruuid', function()
  return io.open('/proc/sys/kernel/random/uuid'):read()
end, { expr = true })

map('ia', 'ctime', function()
  return tostring(os.date('%FT%T%z')):gsub('+(%d%d)(%d%d)$', '+%1:%2')
end, { expr = true })
