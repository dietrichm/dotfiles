vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = { 121 }
vim.bo.commentstring = '// %s'

-- Include and gf file matching.
vim.opt_local.includeexpr = [[substitute(v:fname, '^/', '', '')]]

local augroup = vim.api.nvim_create_augroup('vimrc_php', { clear = true })

-- Colour column 81 only for PHP source files and tests.
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*/{app,domain,src,tests}/*.php',
  group = augroup,
  callback = function()
    vim.opt_local.colorcolumn:append('+1')
  end
})
