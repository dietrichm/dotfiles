-- luacheck: globals FilenameStatusLine SpellStatusLine DiagnosticStatusLine

function FilenameStatusLine()
  local filename = vim.fn.expand('%:~:.')

  if string.len(filename) == 0 then
    return '%f'
  end

  return string.gsub(filename, '%%', '%%%%')
end

function SpellStatusLine()
  if not vim.o.spell then
    return ''
  end

  return string.format('[%s]', vim.o.spelllang)
end

local diagnosticSeverities
if vim.fn.has('nvim-0.10') == 1 then
  diagnosticSeverities = vim.diagnostic.config().signs.text
else
  diagnosticSeverities = {
    [vim.diagnostic.severity.ERROR] = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
    [vim.diagnostic.severity.WARN] = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
    [vim.diagnostic.severity.INFO] = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
    [vim.diagnostic.severity.HINT] = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
  }
end

function DiagnosticStatusLine()
  local items = {}

  for severity, text in ipairs(diagnosticSeverities) do
    local count = #vim.diagnostic.get(0, { severity = severity })

    if count > 0 then
      table.insert(items, string.format('%s%d', text, count))
    end
  end

  return table.concat(items, ' ')
end

vim.o.statusline = [[ %{%v:lua.FilenameStatusLine()%} %y%{v:lua.SpellStatusLine()}%m%r ]]
  .. [[%= %{v:lua.DiagnosticStatusLine()} ]]
