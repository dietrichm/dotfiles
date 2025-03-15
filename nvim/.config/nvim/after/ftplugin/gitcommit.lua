-- luacheck: globals GitBranchIdentifier

vim.opt_local.spell = true
vim.opt_local.list = false
vim.b.editorconfig = false

function GitBranchIdentifier()
  local branch_name = vim.fn.system({ 'git', 'rev-parse', '--abbrev-ref', 'HEAD' })
  local match_start, match_end = vim.regex('[A-Z]\\+-[0-9]\\+'):match_str(branch_name)

  if not match_start then
    return '?'
  end

  return branch_name:sub(match_start + 1, match_end)
end

vim.cmd.iabbrev('<buffer>', '<expr>', 'bri', [[v:lua.GitBranchIdentifier()]])
