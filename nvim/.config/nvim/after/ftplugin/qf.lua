vim.opt_local.cursorlineopt = 'both'
vim.opt_local.number = false
vim.opt_local.showbreak = '    '
vim.opt_local.signcolumn = 'auto'
vim.opt_local.wrap = false

vim.keymap.set('n', "'", [[:Cfilter ]], { buffer = true })
vim.keymap.set('n', '!', [[:Cfilter! ]], { buffer = true })

if vim.w.quickfix_title ~= nil then
  local grepprg = ':' .. vim.o.grepprg:gsub('%-', '%%-')
  vim.w.quickfix_title = vim.w.quickfix_title:gsub(grepprg, 'grep')
end
