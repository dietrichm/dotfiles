-- luacheck: globals GoMockgen

vim.opt_local.colorcolumn:append('100')

local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { buffer = true, silent = true })
end

-- Commands provided by vim-go.
map('n', '<Leader>gb', '<Plug>(go-build)')
map('n', '<Leader>gc', '<Plug>(go-coverage-toggle)')
map('n', '<Leader>gi', '<Plug>(go-imports)')
map('n', '<Leader>gr', '<Plug>(go-run)')
map('n', '<Leader>gt', '<Plug>(go-test)')
map('n', '<Leader>gv', '<Plug>(go-vet)')
map('n', '<Leader>u', '<Plug>(go-import)')

function GoMockgen()
  return string.format(
    '//go:generate go run github.com/golang/mock/mockgen -source %s -destination %s -package %s',
    vim.fn.expand('%:t'),
    vim.fn.expand('%:t:r') .. '_mock.go',
    vim.fn.expand('%:h:t')
  )
end

vim.cmd.iabbrev('mctrl', [[ctrl := gomock.NewController(t)]])
vim.cmd.iabbrev('gnew', [[g := NewWithT(t)]])
vim.cmd.iabbrev('<expr>', 'mockgen', [[v:lua.GoMockgen()]])
vim.cmd.iabbrev('dump', [[fmt.Printf("%+v\n",]])
