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

function DiagnosticStatusLine()
  local items = {}
  local diagnosticSeverities = vim.diagnostic.config().signs.text

  for severity, text in ipairs(diagnosticSeverities) do
    local count = #vim.diagnostic.get(0, { severity = severity })

    if count > 0 then
      table.insert(items, string.format('%s%d', text, count))
    end
  end

  return table.concat(items, ' ')
end

vim.o.statusline = [[ %{%v:lua.FilenameStatusLine()%}%m%r]]
  .. [[%= %{v:lua.DiagnosticStatusLine()} %y%{v:lua.SpellStatusLine()} ]]
