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
    if vim.bo[bufnr].buftype ~= '' then
      return
    end

    if not vim.bo[bufnr].modifiable then
      return
    end

    if vim.bo[bufnr].readonly then
      return
    end

    local excluded_ft = {
      cmdline = true,
      msgbox = true,
      msgcmd = true,
      msgmore = true,
      msgprompt = true,
    }
    local filetype = vim.bo[bufnr].filetype
    if excluded_ft[filetype] ~= nil then
      vim.notify('Excluded from formatting: ' .. filetype, vim.log.levels.WARN)
      return
    end

    return {
      lsp_format = 'fallback',
      timeout_ms = 3000,
    }
  end,
}
