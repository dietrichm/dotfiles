-- Remove `$` from iskeyword set by pangloss/vim-javascript.
vim.opt_local.iskeyword:remove('$')

vim.cmd.match('avoidKeyword', [[/\<instanceof\>/]])
