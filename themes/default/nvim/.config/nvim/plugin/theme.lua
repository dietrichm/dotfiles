vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  group = 'vimrc',
  callback = function()
    vim.cmd.highlight { 'link', 'LspReferenceText', 'IncSearch' }
    vim.cmd.highlight { 'link', 'LspReferenceRead', 'IncSearch' }
    vim.cmd.highlight { 'link', 'LspReferenceWrite', 'IncSearch' }
    vim.cmd.highlight { 'link', 'avoidKeyword', 'DiagnosticUnderlineWarn' }
    vim.cmd.highlight { 'DiagnosticUnderlineError', 'gui=undercurl' }
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default',
  group = 'vimrc',
  callback = function()
    vim.cmd.highlight { 'link', 'ColorColumn', 'CursorLine', bang = true }
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'molokai',
  group = 'vimrc',
  callback = function()
    vim.cmd.highlight { 'StatusLine', 'gui=reverse' } -- Unset bold.
    vim.cmd.highlight { 'link', 'WinBar', 'StatusLine', bang = true }
    vim.cmd.highlight { 'link', 'WinBarNC', 'StatusLineNC', bang = true }
  end,
})

if vim.fn.has('nvim-0.10') == 1 then
  vim.cmd.colorscheme 'default'
else
  pcall(vim.cmd.colorscheme, 'molokai')
end
