local map = vim.keymap.set

map('i', '<S-Tab>', '<Right>')
map('n', '#', [[:setlocal hlsearch | :normal! #<CR>]])
map('n', '*', [[:setlocal hlsearch | :normal! *<CR>]])
map('n', '<Leader>da', [[:%bd<CR>]])
map('n', '<Leader>m', [[:make %<CR>]])
map('n', '<Leader>M', [[:make<CR>]])
map('n', '<Leader>pC', [[:let @+ = expand('%:.') . ":" . line(".")<CR>]])
map('n', '<Leader>pc', [[:let @+ = expand('%:.')<CR>]])
map('n', '<Leader>Pc', [[:let @+ = expand('%:p:~')<CR>]])
map('n', '<Leader>q', vim.diagnostic.setloclist)
map('n', '<Leader>rc', [[:noautocmd update | :TestFile<CR>]])
map('n', '<Leader>rr', [[:noautocmd update | :TestLast<CR>]])
map('n', '<Leader>rt', [[:noautocmd update | :TestNearest<CR>]])
map('n', '<Space>', '')
map('n', '\\', [[:setlocal hlsearch!<CR>]])
map('n', 'g#', [[:setlocal hlsearch | :normal! g#<CR>]])
map('n', 'g*', [[:setlocal hlsearch | :normal! g*<CR>]])
map('n', 'j', [[v:count == 0 && &ft != 'qf' ? 'gj' : 'j']], { expr = true })
map('n', 'k', [[v:count == 0 && &ft != 'qf' ? 'gk' : 'k']], { expr = true })
map('n', '{', [[:keepjumps normal! {<CR>]], { silent = true })
map('n', '}', [[:keepjumps normal! }<CR>]], { silent = true })
map('t', '<Esc>', [[<C-\><C-n>]])

if vim.fn.has('nvim-0.11') == 0 then
  map('n', '[L', [[:lfirst<CR>]])
  map('n', '[l', [[:lprevious<CR>]])
  map('n', '[Q', [[:cfirst<CR>]])
  map('n', '[q', [[:cprevious<CR>]])
  map('n', ']L', [[:llast<CR>]])
  map('n', ']l', [[:lnext<CR>]])
  map('n', ']Q', [[:clast<CR>]])
  map('n', ']q', [[:cnext<CR>]])
end
