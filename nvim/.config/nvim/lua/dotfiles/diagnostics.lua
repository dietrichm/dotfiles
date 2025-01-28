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
    virt_text_pos = vim.fn.has('nvim-0.11') == 1 and 'eol_right_align' or 'eol',
  },
})

vim.keymap.set('n', '<Leader>q', diagnostic.setloclist)

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = vim.api.nvim_create_augroup('dotfiles_diagnostics', { clear = true }),
  callback = function()
    vim.schedule(vim.cmd.redrawstatus)
  end,
})
