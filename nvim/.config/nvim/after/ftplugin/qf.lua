vim.opt_local.cursorlineopt = 'both'
vim.opt_local.number = false
vim.opt_local.showbreak = '    '
vim.opt_local.signcolumn = 'auto'
vim.opt_local.wrap = false

vim.keymap.set('n', "'", [[:Cfilter ]], { buffer = true })
vim.keymap.set('n', '!', [[:Cfilter! ]], { buffer = true })
