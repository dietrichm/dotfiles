vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default',
  group = 'vimrc',
  callback = function()
    vim.cmd.highlight { 'link', 'ColorColumn', 'CursorLine', bang = true }
    vim.cmd.highlight { 'Special', 'gui=italic' }
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'molokai',
  group = 'vimrc',
  callback = function()
    vim.cmd.highlight { 'StatusLine', 'gui=reverse' } -- Unset bold.
    vim.cmd.highlight { 'link', 'WinBar', 'StatusLine', bang = true }
    vim.cmd.highlight { 'link', 'WinBarNC', 'StatusLineNC', bang = true }
    vim.cmd.highlight { 'clear', 'Identifier' }
    vim.cmd.highlight { 'helpHyperTextJump', 'guifg=#FD971F' }
    vim.cmd.highlight { 'SignColumn', 'guibg=NONE' }
    vim.cmd.highlight { 'LineNr', 'guibg=NONE' }
    vim.cmd.highlight { 'link', 'GitSignsAdd', 'diffAdded' }
    vim.cmd.highlight { 'link', 'GitSignsChange', 'Normal' }
    vim.cmd.highlight { 'link', 'GitSignsDelete', 'diffRemoved' }
    vim.cmd.highlight { 'link', 'CurSearch', 'IncSearch' }
    vim.cmd.highlight { 'link', 'LspReferenceText', 'Visual' }
    vim.cmd.highlight { 'link', 'LspReferenceRead', 'Visual' }
    vim.cmd.highlight { 'link', 'LspReferenceWrite', 'Visual' }
    vim.cmd.highlight { 'link', 'LspSignatureActiveParameter', 'Visual' }
  end,
})

if vim.fn.has('nvim-0.10') == 1 then
  vim.cmd.colorscheme 'default'
else
  pcall(vim.cmd.colorscheme, 'molokai')
end
