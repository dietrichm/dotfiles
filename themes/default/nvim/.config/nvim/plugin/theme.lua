vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'molokai',
  group = 'vimrc',
  callback = function()
    vim.cmd.highlight { 'link', 'LspReferenceText', 'IncSearch' }
    vim.cmd.highlight { 'link', 'LspReferenceRead', 'IncSearch' }
    vim.cmd.highlight { 'link', 'LspReferenceWrite', 'IncSearch' }
    vim.cmd.highlight { 'link', 'WinBar', 'StatusLine', bang = true }
    vim.cmd.highlight { 'link', 'WinBarNC', 'StatusLineNC', bang = true }
  end,
})

if vim.fn.has('nvim-0.10') == 0 then
  pcall(vim.cmd.colorscheme, 'molokai')
end
