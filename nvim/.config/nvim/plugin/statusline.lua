local use_null_ls = vim.env.NVIM_USE_NULL_LS == '1'

function _G.SpellStatusLine()
  if not vim.o.spell then
    return ''
  end

  return string.format('[%s]', vim.o.spelllang)
end

local function LSPStatusCounts()
  local has_force_ale_linting, force_ale_linting = pcall(vim.api.nvim_get_var, 'force_ale_linting')

  if has_force_ale_linting and force_ale_linting == 1 then
    return { errors = 0, warnings = 0 }
  end

  return {
    errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }),
    warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }),
  }
end

local function ALEStatusCounts()
  if use_null_ls then
    return { errors = 0, warnings = 0 }
  end

  local buffer = vim.api.nvim_buf_get_number(0)
  local counts = vim.fn['ale#statusline#Count'](buffer)

  return {
    errors = counts.error + counts.style_error,
    warnings = counts.warning + counts.style_warning,
  }
end

function _G.DiagnosticStatusLine()
  local lsp = LSPStatusCounts()
  local ale = ALEStatusCounts()

  if lsp.errors + ale.errors + lsp.warnings + ale.warnings == 0 then
    return ''
  end

  return string.format('❌%d ❗%d', lsp.errors + ale.errors, lsp.warnings + ale.warnings)
end

vim.o.statusline = [[%<%f %y%{v:lua.SpellStatusLine()}%m%r %{v:lua.DiagnosticStatusLine()} %=%-14.(%l,%c%V%) %P]]
