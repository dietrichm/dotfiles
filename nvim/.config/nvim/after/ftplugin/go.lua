-- luacheck: globals GoMockgen

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
