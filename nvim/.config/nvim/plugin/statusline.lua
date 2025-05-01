local function name()
  if vim.o.filetype == 'help' then
    return '%f'
  end

  local filename = vim.fn.expand('%:~:.')

  if filename:len() == 0 then
    return '%f'
  end

  return filename:gsub('%%', '%%%%')
end

local function spell()
  if not vim.o.spell then
    return ''
  end

  return string.format('[%s]', vim.o.spelllang)
end

local function diagnostic()
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

function _G.MyStatusLine()
  return table
    .concat({
      ' ',
      name(),
      ' ',
      '%m',
      '%r',
      '%=',
      vim.b.gitsigns_status or '',
      ' ',
      diagnostic(),
      ' ',
      '%y',
      spell(),
      ' ',
    })
    :gsub('%s+', ' ')
end

vim.o.statusline = [[%{%v:lua.MyStatusLine()%}]]

local augroup = vim.api.nvim_create_augroup('MyStatusLine', { clear = true })

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = augroup,
  callback = function()
    vim.schedule(vim.cmd.redrawstatus)
  end,
})

vim.api.nvim_create_autocmd('User', {
  group = augroup,
  pattern = 'GitSignsUpdate',
  callback = function()
    vim.schedule(vim.cmd.redrawstatus)
  end,
})
