vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn:append('121')
vim.bo.commentstring = '// %s'

-- Include and gf file matching.
vim.opt_local.includeexpr = [[substitute(v:fname, '^/', '', '')]]

-- Partial namespace from path.
vim.cmd.iabbrev('<expr>', 'ns', [[substitute(tr(expand('%:p:h'), '/', '\'), '\v^.*\\\l[^\\]*\\?', '', '')]])
