local augroup = vim.api.nvim_create_augroup('dotfiles_colorscheme', { clear = true })
local hi = vim.cmd.highlight

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default',
  group = augroup,
  callback = function()
    hi { 'DiagnosticUnderlineError', 'gui=undercurl' }
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
    hi { 'MiniPickMatchRanges', 'gui=underline', 'guifg=NvimLightYellow' }
  end,
})

vim.cmd.colorscheme('default')
