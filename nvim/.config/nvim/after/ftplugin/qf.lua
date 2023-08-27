vim.opt_local.number = false

vim.cmd([[
  if empty(getloclist(0))
      wincmd J
  endif
]])
