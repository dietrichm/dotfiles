local opts = { buffer = true, silent = true }

-- Commands provided by vim-go.
vim.keymap.set('n', '<Leader>gb', '<Plug>(go-build)', opts)
vim.keymap.set('n', '<Leader>gc', '<Plug>(go-coverage-toggle)', opts)
vim.keymap.set('n', '<Leader>gi', '<Plug>(go-imports)', opts)
vim.keymap.set('n', '<Leader>gr', '<Plug>(go-run)', opts)
vim.keymap.set('n', '<Leader>gt', '<Plug>(go-test)', opts)
vim.keymap.set('n', '<Leader>gv', '<Plug>(go-vet)', opts)
vim.keymap.set('n', '<Leader>u', '<Plug>(go-import)', opts)
