vim.opt_local.number = false
vim.opt_local.signcolumn = 'no'

vim.cmd([[
  if empty(getloclist(0))
      wincmd J
  endif
]])
