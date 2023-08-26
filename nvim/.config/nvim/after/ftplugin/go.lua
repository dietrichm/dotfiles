-- luacheck: globals GoMockgen

local opts = { buffer = true, silent = true }

-- Commands provided by vim-go.
vim.keymap.set('n', '<Leader>gb', '<Plug>(go-build)', opts)
vim.keymap.set('n', '<Leader>gc', '<Plug>(go-coverage-toggle)', opts)
vim.keymap.set('n', '<Leader>gi', '<Plug>(go-imports)', opts)
vim.keymap.set('n', '<Leader>gr', '<Plug>(go-run)', opts)
vim.keymap.set('n', '<Leader>gt', '<Plug>(go-test)', opts)
vim.keymap.set('n', '<Leader>gv', '<Plug>(go-vet)', opts)
vim.keymap.set('n', '<Leader>u', '<Plug>(go-import)', opts)

function GoMockgen()
  return string.format(
    '//go:generate go run github.com/golang/mock/mockgen -source %s -destination %s -package %s',
    vim.fn.expand('%:t'),
    vim.fn.expand('%:t:r') .. '_mock.go',
    vim.fn.expand('%:h:t')
  )
end

vim.cmd.iabbrev('mctrl', [[ctrl := gomock.NewController(t)]])
vim.cmd.iabbrev('<expr>', 'mockgen', [[v:lua.GoMockgen()]])
vim.cmd.iabbrev('dump', [[fmt.Printf("%+v\n", ]])
