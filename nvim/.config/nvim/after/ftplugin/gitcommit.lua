vim.opt_local.spell = true
vim.opt_local.list = false
vim.b.editorconfig = false

function _G.GitBranchIdentifier()
  local branch_name = vim.fn.system { 'git', 'rev-parse', '--abbrev-ref', 'HEAD' }
  local match_start, match_end = vim.regex('[A-Z]\\+-[0-9]\\+'):match_str(branch_name)

  if not match_start then
    return '?'
  end

  return branch_name:sub(match_start + 1, match_end)
end

function _G.GitCachedFiles()
  local output = vim.fn.system { 'git', 'diff', '--cached', '--name-only' }
  local filenames = vim.iter(vim.split(output:gsub('\n$', ''), '\n'))

  return filenames
    :map(function(filename)
      return vim.fn.fnamemodify(filename, ':t')
    end)
    :map(function(filename)
      return string.format('`%s`', filename)
    end)
    :join(' and ')
end

vim.cmd.iabbrev('<buffer>', '<expr>', 'bri', [[v:lua.GitBranchIdentifier()]])
vim.cmd.iabbrev('<buffer>', '<expr>', 'cfs', [[v:lua.GitCachedFiles()]])
