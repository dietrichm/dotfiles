local diagnostic = vim.diagnostic

diagnostic.config {
  signs = {
    text = {
      [diagnostic.severity.ERROR] = '🪲',
      [diagnostic.severity.WARN] = '🚨',
      [diagnostic.severity.INFO] = '💡',
      [diagnostic.severity.HINT] = '💭',
    },
  },
  virtual_text = {
    current_line = true,
    prefix = '●',
  },
  severity_sort = true,
}
