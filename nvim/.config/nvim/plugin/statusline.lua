local augroup = vim.api.nvim_create_augroup('statusline', { clear = true })

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = augroup,
  callback = function(args)
    local diagnosticSeverities = vim.diagnostic.config().signs.text

    if diagnosticSeverities == nil then
      return
    end

    local items = {}
    local counts = vim.diagnostic.count(args.buf)

    for severity, text in ipairs(diagnosticSeverities) do
      if counts[severity] ~= nil then
        table.insert(items, string.format('%s%d', text, counts[severity]))
      end
    end

    vim.b[args.buf].diagnostic_status = table.concat(items, ' ')
    vim.api.nvim__redraw { buf = args.buf, statusline = true }
  end,
})

function _G.spaced(key)
  local value = vim.b[key]

  if value == nil or value == '' then
    return ''
  end

  return value .. ' '
end

vim.o.statusline = [[ %<%f %h%m%r %=%{v:lua.spaced('gitsigns_status')}%{v:lua.spaced('diagnostic_status')}]]
