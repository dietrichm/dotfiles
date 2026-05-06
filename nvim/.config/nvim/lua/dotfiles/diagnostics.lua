local diagnostic = vim.diagnostic

local signs = {
  [diagnostic.severity.ERROR] = '❌',
  [diagnostic.severity.WARN] = '⚠️',
  [diagnostic.severity.INFO] = 'ℹ️',
  [diagnostic.severity.HINT] = '💡',
}

diagnostic.config {
  signs = {
    text = signs,
  },
  status = {
    format = signs,
  },
  virtual_text = {
    current_line = true,
    prefix = '●',
  },
  severity_sort = true,
}
