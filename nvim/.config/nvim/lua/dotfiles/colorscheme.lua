vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default',
  group = vim.api.nvim_create_augroup('dotfiles_colorscheme', { clear = true }),
  callback = function()
    local hi = vim.cmd.highlight

    hi { 'DiagnosticUnderlineError', 'gui=undercurl' }
    hi { 'link', 'ColorColumn', 'CursorLine', bang = true }
    hi { 'MiniPickMatchRanges', 'gui=underline' }
    hi { 'TreesitterContextBottom', 'gui=underline' }

    if vim.o.background == 'dark' then
      hi { 'Added', 'guifg=NvimLightBlue' }
      hi { 'Changed', 'guifg=NvimLightYellow' }
      hi { 'FloatBorder', 'guifg=NvimDarkGrey4', 'guibg=NvimDarkGrey1' }
      hi { 'MiniPickMatchRanges', 'guifg=NvimLightYellow' }
      hi { 'NonText', 'guifg=grey' }
      hi { 'TreesitterContextBottom', 'guisp=NvimDarkGrey4' }
    end
  end,
})

vim.cmd.colorscheme('default')
