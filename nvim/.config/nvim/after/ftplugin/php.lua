vim.opt_local.matchpairs:remove('<:>')
vim.opt_local.includeexpr = [[substitute(v:fname, '^/', '', '')]]
vim.bo.commentstring = '// %s'
vim.b.delimitMate_matchpairs = '(:),[:],{:}'

vim.cmd.iabbrev('<buffer>', '<expr>', 'ns', [[substitute(tr(expand('%:p:h'), '/', '\'), '\v^.*\\\l[^\\]*\\?', '', '')]])
vim.cmd.iabbrev('<buffer>', '<expr>', 'cls', [[expand('%:t:r')]])
vim.cmd.iabbrev('<buffer>', 'strict', [[declare(strict_types=1);]])

vim.keymap.set('n', '<Leader>af', [[:PhpFields<CR>]], { buffer = true, silent = true })
