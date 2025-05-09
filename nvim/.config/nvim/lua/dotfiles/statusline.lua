vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = vim.api.nvim_create_augroup('dotfiles_statusline', { clear = true }),
  callback = function(args)
    local severities = vim.diagnostic.config().signs.text

    if severities == nil then
      return
    end

    local items = {}
    local counts = vim.diagnostic.count(args.buf)

    for severity, text in ipairs(severities) do
      if counts[severity] ~= nil then
        table.insert(items, string.format('%s%d', text, counts[severity]))
      end
    end

    vim.b[args.buf].diagnostic_status = table.concat(items, ' ')
    vim.api.nvim__redraw { buf = args.buf, statusline = true }
  end,
})

vim.g.qf_disable_statusline = 1
vim.o.statusline = [[ %<%f%( %{get(w:, 'quickfix_title', '')}%) %h%m%r %=]]
  .. [[%(%{get(b:, 'gitsigns_status', '')} %)%(%{get(b:, 'diagnostic_status', '')} %)]]
