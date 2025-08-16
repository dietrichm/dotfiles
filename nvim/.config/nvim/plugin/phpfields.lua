local function feedkeys(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'm', false)
end

function _G.PhpFields()
  local startPosition = vim.fn.searchpair('(', '', ')', 'nb')
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
    local fields = vim.iter(label:gmatch('$([^ ,)]+)')):take(argumentCount)
    vim.api.nvim_win_set_cursor(0, { startPosition + 1, 0 })

    fields:each(function(field)
      feedkeys('I' .. field .. ': <Esc>j')
    end)
  end)
end

function _G.PhpFieldsTS()
  local node = vim.treesitter.get_node()

  if node == nil then
    vim.notify('Unable to get current node.', vim.log.levels.ERROR)
    return
  end

  local function_call = node

  while function_call:type() ~= 'function_call_expression' do
    local try_parent = function_call:parent()

    if try_parent == nil then
      vim.notify('Unable to find function call.', vim.log.levels.ERROR)
      return
    end

    function_call = try_parent
  end

  local arguments_query = vim.treesitter.query.parse(
    'php',
    [[
      (arguments
        (argument
          name: (name)? @field_name) @argument)
    ]]
  )
  local arguments = {}

  for _, argument in
    arguments_query:iter_captures(function_call, 0, nil, nil, {
      max_start_depth = 1,
    })
  do
    arguments[#arguments + 1] = argument
  end

  print(vim.inspect(arguments))
end
