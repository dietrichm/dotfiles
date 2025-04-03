local loaded, conform = pcall(require, 'conform')
if not loaded then
  return
end

conform.setup {
  formatters_by_ft = {
    go = {
      'gofumpt',
      'gofmt',
      stop_after_first = true,
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
  format_on_save = function(bufnr)
    if not vim.bo[bufnr].modifiable then
      return
    end

    if vim.bo[bufnr].readonly then
      return
    end

    return {
      lsp_format = 'fallback',
      timeout_ms = 1500,
    }
  end,
}
