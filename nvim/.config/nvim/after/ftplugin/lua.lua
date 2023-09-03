vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.textwidth = 120

vim.cmd.iabbrev('dump', [[print(vim.inspect(]])

-- Surround text with `]` places double brackets.
vim.b.surround_93 = '[[\r]]'
