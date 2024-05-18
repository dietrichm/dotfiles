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
  local diagnosticSeverities = vim.diagnostic.config().signs.text

  if diagnosticSeverities == nil then
    return ''
  end

  local items = {}
  local counts = vim.diagnostic.count(0)

  for severity, text in ipairs(diagnosticSeverities) do
    if counts[severity] ~= nil then
      table.insert(items, string.format('%s%d', text, counts[severity]))
    end
  end

  return table.concat(items, ' ')
end

vim.o.statusline = [[ %{%v:lua.FilenameStatusLine()%}%m%r]]
  .. [[%= %{v:lua.DiagnosticStatusLine()} %y%{v:lua.SpellStatusLine()} ]]
