vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'molokai',
  group = 'vimrc',
  callback = function()
    vim.cmd.highlight { 'link', 'LspReferenceText', 'IncSearch' }
    vim.cmd.highlight { 'link', 'LspReferenceRead', 'IncSearch' }
    vim.cmd.highlight { 'link', 'LspReferenceWrite', 'IncSearch' }
  end,
})

pcall(vim.cmd.colorscheme, 'molokai')
