vim.opt_local.matchpairs:remove('<:>')
vim.bo.commentstring = '// %s'
vim.b.delimitMate_matchpairs = '(:),[:],{:}'

-- Include and gf file matching.
vim.opt_local.includeexpr = [[substitute(v:fname, '^/', '', '')]]

-- Partial namespace from path.
vim.cmd.iabbrev('<expr>', 'ns', [[substitute(tr(expand('%:p:h'), '/', '\'), '\v^.*\\\l[^\\]*\\?', '', '')]])

vim.cmd.iabbrev('<expr>', 'cls', [[expand('%:t:r')]])
