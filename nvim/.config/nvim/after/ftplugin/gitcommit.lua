vim.opt_local.spell = true
vim.opt_local.list = false
vim.b.editorconfig = false

vim.keymap.set('ia', 'bri', function()
  local branch_name = vim.fn.system { 'git', 'rev-parse', '--abbrev-ref', 'HEAD' }
  local match_start, match_end = vim.regex('[A-Z]\\+-[0-9]\\+'):match_str(branch_name)

  if not match_start then
    return '?'
  end

  return branch_name:sub(match_start + 1, match_end)
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
