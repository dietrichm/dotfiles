vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default',
  group = 'vimrc',
  callback = function()
    vim.cmd.highlight { 'link', 'ColorColumn', 'CursorLine', bang = true }
    vim.cmd.highlight { 'TreesitterContextBottom', 'gui=underline', 'guisp=NvimDarkGrey4' }
  end,
})

vim.cmd.colorscheme 'default'
