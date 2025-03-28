local diagnostic = vim.diagnostic

local virtual_text = {
  severity = {
    min = diagnostic.severity.WARN,
  },
  prefix = '●',
}

if vim.fn.has('nvim-0.11') == 1 then
  virtual_text = {
    current_line = true,
    prefix = '●',
  }
end

diagnostic.config({
  signs = {
    text = {
      [diagnostic.severity.ERROR] = '🪲',
      [diagnostic.severity.WARN] = '🚨',
      [diagnostic.severity.INFO] = '💡',
      [diagnostic.severity.HINT] = '💭',
    },
  },
  virtual_text = virtual_text,
  severity_sort = true,
})

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = vim.api.nvim_create_augroup('dotfiles_diagnostics', { clear = true }),
  callback = function()
    vim.schedule(vim.cmd.redrawstatus)
  end,
})
