vim.opt_local.nonumber = true
vim.opt_local.signcolumn = 'no'

vim.cmd([[
  if empty(getloclist(0))
      wincmd J
  endif
]])
