-- luacheck: globals SpellStatusLine DiagnosticStatusLine

function SpellStatusLine()
  if not vim.o.spell then
    return ''
  end

  return string.format('[%s]', vim.o.spelllang)
end

local diagnosticSeverities = {
  [vim.diagnostic.severity.ERROR] = vim.fn.sign_getdefined('DiagnosticSignError')[1],
  [vim.diagnostic.severity.WARN] = vim.fn.sign_getdefined('DiagnosticSignWarn')[1],
  [vim.diagnostic.severity.INFO] = vim.fn.sign_getdefined('DiagnosticSignInfo')[1],
  [vim.diagnostic.severity.HINT] = vim.fn.sign_getdefined('DiagnosticSignHint')[1],
}

function DiagnosticStatusLine()
  local items = {}

  for severity, sign in ipairs(diagnosticSeverities) do
    local count = #vim.diagnostic.get(0, { severity = severity })

    if count > 0 then
      table.insert(items, string.format('%s%d', sign.text, count))
    end
  end

  return table.concat(items, ' ')
end

vim.o.statusline = [[%<%f %y%{v:lua.SpellStatusLine()}%m%r %{v:lua.DiagnosticStatusLine()} %=%-14.(%l,%c%V%) %P]]
