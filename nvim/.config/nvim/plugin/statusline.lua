local augroup = vim.api.nvim_create_augroup('statusline', { clear = true })

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = augroup,
  callback = function(args)
    local severities = vim.diagnostic.config().signs.text

    if severities == nil then
      return
    end

    local items = {}
    local counts = vim.diagnostic.count(args.buf)

    for severity, text in ipairs(severities) do
      if counts[severity] ~= nil then
        table.insert(items, string.format('%s%d', text, counts[severity]))
      end
    end

    vim.b[args.buf].diagnostic_status = table.concat(items, ' ')
    vim.api.nvim__redraw { buf = args.buf, statusline = true }
  end,
})

function _G.lspaced(key)
  local value = vim.b[key] or vim.w[key]

  if value == nil or value == '' then
    return ''
  end

  return ' ' .. value
end

function _G.rspaced(key)
  local value = vim.b[key] or vim.w[key]

  if value == nil or value == '' then
    return ''
  end

  return value .. ' '
end

vim.g.qf_disable_statusline = 1
vim.o.statusline = [[ %<%f%{v:lua.lspaced('quickfix_title')} %h%m%r %=]]
  .. [[%{v:lua.rspaced('gitsigns_status')}%{v:lua.rspaced('diagnostic_status')}]]
