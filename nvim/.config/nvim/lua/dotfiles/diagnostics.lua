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
    format = function(counts)
      local parts = {}
      for severity, count in pairs(counts) do
        table.insert(parts, signs[severity] .. count)
      end
      return table.concat(parts, ' ')
    end,
  },
  virtual_text = {
    current_line = true,
    prefix = '●',
  },
  severity_sort = true,
}
