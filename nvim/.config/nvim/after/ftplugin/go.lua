local map = vim.keymap.set

map('ia', 'mctrl', [[ctrl := gomock.NewController(t)]], { buffer = true })
map('ia', 'gnew', [[g := NewWithT(t)]], { buffer = true })
map('ia', 'dump', [[fmt.Printf("%+v\n", )<Left>]], { buffer = true })
map('ia', 'errn', [[if err != nil {}<Left>]], { buffer = true })

map('ia', 'mockgen', function()
  return string.format(
    '//go:generate go run github.com/golang/mock/mockgen -source %s -destination %s -package %s',
    vim.fn.expand('%:t'),
    vim.fn.expand('%:t:r') .. '_mock.go',
    vim.fn.expand('%:h:t')
  )
end, { buffer = true, expr = true })

map('n', '<Leader>ft', function()
  local filename = vim.fn.expand('%:.')
  if filename:match('_test.go$') ~= nil then
    vim.notify('Not a source file.', vim.log.levels.ERROR)
    return
  end
  filename = filename:gsub('%.go$', '_test.go')
  vim.cmd.vsplit(filename)
end, { buffer = true })
