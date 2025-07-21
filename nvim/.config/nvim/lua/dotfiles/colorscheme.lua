local augroup = vim.api.nvim_create_augroup('dotfiles_colorscheme', { clear = true })
local hi = vim.cmd.highlight

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  group = augroup,
  callback = function()
    hi { 'DiagnosticUnderlineError', 'gui=undercurl' }
    hi { 'link', 'TelescopeNormal', 'NormalFloat' }
    hi { 'link', 'TelescopeMatching', 'Search' }
    hi { 'link', 'TelescopeSelection', 'CursorLine' }
    hi { 'link', 'TelescopeBorder', 'FloatBorder' }
    hi { 'link', 'TelescopeTitle', 'FloatTitle' }
    hi { 'link', 'TelescopePromptCounter', 'Comment' }
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default',
  group = augroup,
  callback = function()
    hi { 'link', 'ColorColumn', 'CursorLine', bang = true }
    hi { 'TreesitterContextBottom', 'gui=underline', 'guisp=NvimDarkGrey4' }
    if vim.env.TERM == 'xterm-kitty' then
      hi { '@comment', 'guifg=NvimLightGrey4', 'gui=italic' }
    end
    hi { 'link', 'LspInlayHint', '@comment' }
    hi { 'Added', 'guifg=NvimLightBlue' }
    hi { 'Changed', 'guifg=NvimLightYellow' }
    hi { 'FloatBorder', 'guifg=NvimDarkGrey4', 'guibg=NvimDarkGrey1' }
    hi { 'qfText', 'guifg=NvimLightGrey2' }
  end,
})

vim.cmd.colorscheme('default')
