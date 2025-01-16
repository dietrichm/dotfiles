local loaded, conform = pcall(require, 'conform')
if not loaded then
  return
end

conform.setup {
  formatters_by_ft = {
    go = {
      'goimports',
    },
    php = {
      'pint',
      'php_cs_fixer',
      stop_after_first = true,
    },
    javascript = {
      'prettier',
    },
    lua = {
      'stylua',
    },
    python = {
      'isort',
      'black',
    },
    typescript = {
      'prettier',
    },
    typescriptreact = {
      'prettier',
    },
  },
  format_on_save = {
    lsp_format = 'fallback',
    timeout_ms = 500,
  },
}
