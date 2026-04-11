local map = vim.keymap.set

map('ia', 'mctrl', [[ctrl := gomock.NewController(t)]], { buf = 0 })
map('ia', 'gnew', [[g := NewWithT(t)]], { buf = 0 })

map('ia', 'mockgen', function()
  return string.format(
    '//go:generate go run github.com/golang/mock/mockgen -source %s -destination %s -package %s',
    vim.fn.expand('%:t'),
    vim.fn.expand('%:t:r') .. '_mock.go',
    vim.fn.expand('%:h:t')
  )
end, { buf = 0, expr = true })

map('n', '<Leader>ft', function()
  local filename = vim.fn.expand('%:.')
  if filename:match('_test.go$') ~= nil then
    vim.notify('Not a source file.', vim.log.levels.ERROR)
    return
  end
  filename = filename:gsub('%.go$', '_test.go')
  vim.cmd.vsplit(filename)
end, { buf = 0 })
