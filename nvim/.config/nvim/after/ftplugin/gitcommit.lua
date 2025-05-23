vim.opt_local.spell = true
vim.opt_local.list = false
vim.b.editorconfig = false

vim.keymap.set('ia', 'bri', function()
  local branch_name = vim.fn.system { 'git', 'rev-parse', '--abbrev-ref', 'HEAD' }
  return branch_name:match('%u+%-%d+') or '?'
end, { buffer = true, expr = true })

vim.keymap.set('ia', 'cfs', function()
  local output = vim.fn.system { 'git', 'diff', '--cached', '--name-only' }
  local filenames = vim.iter(vim.split(output:gsub('\n$', ''), '\n'))

  return filenames
    :map(function(filename)
      return vim.fs.basename(filename)
    end)
    :map(function(filename)
      return string.format('`%s`', filename)
    end)
    :join(' and ')
end, { buffer = true, expr = true })
