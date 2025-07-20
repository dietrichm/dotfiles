vim.opt_local.wrap = true
vim.opt_local.signcolumn = 'auto'

vim.keymap.set('n', "'", [[:Cfilter ]], { buffer = true })
vim.keymap.set('n', '!', [[:Cfilter! ]], { buffer = true })
