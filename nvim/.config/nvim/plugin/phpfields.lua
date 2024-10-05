local function feedkeys(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'm', false)
end

local function applyFields()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, 'textDocument/signatureHelp', params, function(_, result)
    if not result or not result.signatures then
      vim.notify('No signature found to apply PHP fields.', vim.log.levels.ERROR)
      return
    end

    local label = result.signatures[1].label
    feedkeys("vib<Esc>'<")

    -- Expect to be positioned on first argument with one argument per line.
    for field in string.gmatch(label, '$([^ ,)]+)') do
      feedkeys('I' .. field .. ': <Esc>j')
    end
  end)
end

vim.api.nvim_create_user_command('PhpFields', function()
  applyFields()
end, {})
