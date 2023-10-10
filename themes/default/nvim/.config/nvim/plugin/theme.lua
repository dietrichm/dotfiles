vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'molokai',
  group = 'vimrc',
  callback = function()
    vim.cmd.highlight { 'LspReferenceText', 'guibg=#4c4745' }
    vim.cmd.highlight { 'LspReferenceRead', 'guibg=#4c4745' }
    vim.cmd.highlight { 'LspReferenceWrite', 'guibg=#4c4745' }
  end
})

vim.cmd.colorscheme('molokai')
