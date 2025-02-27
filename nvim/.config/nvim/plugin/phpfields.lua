-- luacheck: globals PhpFields

local function feedkeys(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'm', false)
end

function PhpFields()
  ---@diagnostic disable-next-line: redundant-parameter
  local startPosition = vim.fn.searchpair('(', '', ')', 'nb')
  ---@diagnostic disable-next-line: redundant-parameter
  local endPosition = vim.fn.searchpair('(', '', ')', 'n')
  local argumentCount = endPosition - startPosition - 1

  if argumentCount < 1 then
    vim.notify('Can only apply PHP fields to calls with one argument per line.', vim.log.levels.ERROR)
    return
  end

  local params = vim.lsp.util.make_position_params(0, 'utf-16')
  vim.lsp.buf_request(0, 'textDocument/signatureHelp', params, function(_, result)
    if not result or not result.signatures then
      vim.notify('No signature found to apply PHP fields.', vim.log.levels.ERROR)
      return
    end

    local label = result.signatures[1].label
    local fields = vim.iter(string.gmatch(label, '$([^ ,)]+)')):take(argumentCount)
    vim.api.nvim_win_set_cursor(0, { startPosition + 1, 0 })

    fields:each(function(field)
      feedkeys('I' .. field .. ': <Esc>j')
    end)
  end)
end
