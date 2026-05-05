vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'default',
  group = vim.api.nvim_create_augroup('dotfiles_colorscheme', { clear = true }),
  callback = function()
    local hi = function(name, val)
      val.update = true
      vim.api.nvim_set_hl(0, name, val)
    end

    hi('ColorColumn', { link = 'CursorLine' })
    hi('DiagnosticUnderlineError', { undercurl = true })
    hi('DiagnosticUnderlineHint', { underline = false })
    hi('MiniPickMatchRanges', { underline = true })
    hi('Sneak', { link = 'Search' })
    hi('SneakCurrent', { link = 'CurSearch' })
    hi('TreesitterContextBottom', { underline = true })

    if vim.o.background == 'dark' then
      hi('Added', { fg = 'NvimLightBlue' })
      hi('Changed', { fg = 'NvimLightYellow' })
      hi('FloatBorder', { fg = 'NvimDarkGrey4', bg = 'NvimDarkGrey2' })
      hi('MiniPickMatchRanges', { fg = 'NvimLightYellow' })
      hi('Normal', { bg = 'Black' })
      hi('NormalFloat', { bg = 'NvimDarkGrey2' })
      hi('TreesitterContextBottom', { sp = 'NvimDarkGrey4' })
    end
  end,
})

vim.cmd.colorscheme('default')
