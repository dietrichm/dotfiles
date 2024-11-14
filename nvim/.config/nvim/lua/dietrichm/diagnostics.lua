local diagnostic = vim.diagnostic

diagnostic.config({
  signs = {
    text = {
      [diagnostic.severity.ERROR] = '🪲',
      [diagnostic.severity.WARN] = '🚨',
      [diagnostic.severity.INFO] = '💡',
      [diagnostic.severity.HINT] = '💭',
    },
  },
  virtual_text = {
    severity = {
      min = diagnostic.severity.WARN,
    },
    prefix = '●',
  },
})

vim.keymap.set('n', '<Leader>q', diagnostic.setloclist, { silent = true })

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = 'vimrc',
  callback = function()
    vim.schedule(vim.cmd.redrawstatus)
  end,
})
