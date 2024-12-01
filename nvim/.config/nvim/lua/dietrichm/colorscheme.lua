vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  group = 'vimrc',
  callback = function()
    vim.cmd.highlight { 'DiagnosticUnderlineError', 'gui=undercurl' }
    vim.cmd.highlight { 'link', 'TelescopeNormal', 'NormalFloat' }
    vim.cmd.highlight { 'link', 'TelescopeMatching', 'IncSearch' }
    vim.cmd.highlight { 'link', 'TelescopeSelection', 'CursorLine' }
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default',
  group = 'vimrc',
  callback = function()
    vim.cmd.highlight { 'link', 'ColorColumn', 'CursorLine', bang = true }
    vim.cmd.highlight { 'TreesitterContextBottom', 'gui=underline', 'guisp=NvimDarkGrey4' }
  end,
})

vim.cmd.colorscheme 'default'
