vim.opt_local.matchpairs:remove('<:>')
vim.opt_local.includeexpr = [[substitute(v:fname, '^/', '', '')]]
vim.bo.commentstring = '// %s'

vim.cmd.iabbrev('<buffer>', '<expr>', 'ns', [[substitute(tr(expand('%:p:h'), '/', '\'), '\v^.*\\\l[^\\]*\\?', '', '')]])

vim.keymap.set('n', 'grf', _G.PhpFields, { buffer = true })
