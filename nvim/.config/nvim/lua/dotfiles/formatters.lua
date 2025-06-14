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
    local opts = vim.bo[bufnr]
    local filetype = opts.filetype

    if opts.buftype ~= '' then
      return
    end

    if not opts.modifiable then
      return
    end

    if opts.readonly then
      return
    end

    local excluded_ft = {
      cmdline = true,
      msgbox = true,
      msgcmd = true,
      msgmore = true,
      msgprompt = true,
    }
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
