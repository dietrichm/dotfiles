vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = vim.api.nvim_create_augroup('dotfiles_statusline', { clear = true }),
  callback = function(args)
    local severities = vim.diagnostic.config().signs.text

    if severities == nil then
      return
    end

    local items = {}
    local bufnr = args.buf
    local counts = vim.diagnostic.count(bufnr)

    for severity, text in ipairs(severities) do
      if counts[severity] ~= nil then
        table.insert(items, ('%s%d'):format(text, counts[severity]))
      end
    end

    vim.b[bufnr].diagnostic_status = table.concat(items, ' ')
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim__redraw { buf = bufnr, statusline = true }
      end
    end)
  end,
})

vim.g.qf_disable_statusline = 1
vim.o.statusline = [[ %<%f%( %{get(w:, 'quickfix_title', '')}%) %h%m%r %=]]
  .. [[%{% has('nvim-0.12') && &busy > 0 ? '⏳ ' : '' %}]]
  .. [[%(%{get(b:, 'gitsigns_status', '')} %)%(%{get(b:, 'diagnostic_status', '')} %)]]
  .. [[%{% &buftype == 'quickfix' ? '%l/%L ' : '' %}]]
