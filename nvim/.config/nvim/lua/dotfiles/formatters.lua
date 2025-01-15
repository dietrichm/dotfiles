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
      'php_cs_fixer',
      'pint',
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
