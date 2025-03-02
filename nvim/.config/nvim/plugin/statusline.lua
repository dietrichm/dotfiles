-- luacheck: globals MyStatusLine

local function name()
  local filename = vim.fn.expand('%:~:.')

  if string.len(filename) == 0 then
    return '%f'
  end

  return string.gsub(filename, '%%', '%%%%')
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

function MyStatusLine()
  return table.concat({
    ' ',
    name(),
    '%m',
    '%r',
    '%=',
    diagnostic(),
    ' ',
    '%y',
    spell(),
    ' ',
  })
end

vim.o.statusline = [[%{%v:lua.MyStatusLine()%}]]
