vim.opt_local.matchpairs:remove('<:>')
vim.bo.commentstring = '// %s'

vim.keymap.set('n', 'grf', _G.PhpFields, { buf = 0 })

vim.keymap.set('n', '<Leader>ft', function()
  local filename = vim.fn.expand('%:.')
  if filename:match('^src/') == nil then
    vim.notify('Not a source file.', vim.log.levels.ERROR)
    return
  end
  filename = filename:gsub('^src/', vim.g.php_tests_prefix or 'tests/')
  filename = filename:gsub('%.php$', 'Test.php')
  vim.cmd.vsplit(filename)
end, { buf = 0 })
