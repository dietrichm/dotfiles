local augroup = vim.api.nvim_create_augroup('dotfiles_colorscheme', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  group = augroup,
  callback = function()
    vim.cmd.highlight { 'DiagnosticUnderlineError', 'gui=undercurl' }
    vim.cmd.highlight { 'link', 'TelescopeNormal', 'NormalFloat' }
    vim.cmd.highlight { 'link', 'TelescopeMatching', 'IncSearch' }
    vim.cmd.highlight { 'link', 'TelescopeSelection', 'CursorLine' }
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default',
  group = augroup,
  callback = function()
    vim.cmd.highlight { 'link', 'ColorColumn', 'CursorLine', bang = true }
    vim.cmd.highlight { 'TreesitterContextBottom', 'gui=underline', 'guisp=NvimDarkGrey4' }
    vim.cmd.highlight { '@comment', 'guifg=NvimLightGrey4', 'gui=italic' }
    vim.cmd.highlight { 'link', 'LspInlayHint', '@comment' }
  end,
})

vim.cmd.colorscheme 'default'
