vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.textwidth = 120

vim.cmd.iabbrev('dump', [[print(vim.inspect(]])

-- Surround text with `]` places double brackets.
vim.b.surround_93 = '[[\r]]'

vim.api.nvim_create_autocmd('BufWritePost', {
  buffer = 0,
  group = 'vimrc',
  callback = function()
    vim.cmd.FormatWrite()
  end,
})
