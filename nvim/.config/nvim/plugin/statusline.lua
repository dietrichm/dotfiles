function _G.SpellStatusLine()
  if not vim.o.spell then
    return ''
  end

  return string.format('[%s]', vim.o.spelllang)
end

local function LSPStatusCounts()
  return {
    errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }),
    warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }),
  }
end

function _G.DiagnosticStatusLine()
  local lsp = LSPStatusCounts()

  if lsp.errors + lsp.warnings == 0 then
    return ''
  end

  return string.format('❌%d ❗%d', lsp.errors, lsp.warnings)
end

vim.o.statusline = [[%<%f %y%{v:lua.SpellStatusLine()}%m%r %{v:lua.DiagnosticStatusLine()} %=%-14.(%l,%c%V%) %P]]
