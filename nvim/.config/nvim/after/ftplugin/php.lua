vim.opt_local.matchpairs:remove('<:>')
vim.opt_local.includeexpr = [[substitute(v:fname, '^/', '', '')]]
vim.bo.commentstring = '// %s'
vim.b.delimitMate_matchpairs = '(:),[:],{:}'

vim.cmd.iabbrev('<expr>', 'ns', [[substitute(tr(expand('%:p:h'), '/', '\'), '\v^.*\\\l[^\\]*\\?', '', '')]])
vim.cmd.iabbrev('<expr>', 'cls', [[expand('%:t:r')]])

vim.keymap.set('n', '<Leader>af', [[:PhpFields<CR>]], { buffer = true, silent = true })
