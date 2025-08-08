vim.g.qf_disable_statusline = 1

if vim.fn.has('nvim-0.12') == 1 then
  vim.opt.statusline:prepend(' ')
  return
end

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = vim.api.nvim_create_augroup('dotfiles_statusline', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local severities = vim.diagnostic.config().signs.text

    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end

    if severities == nil then
      return
    end

    local items = {}
    local counts = vim.diagnostic.count(bufnr)

    for severity, text in ipairs(severities) do
      if counts[severity] ~= nil then
        table.insert(items, ('%s:%d'):format(text, counts[severity]))
      end
    end

    vim.b[bufnr].diagnostic_status = table.concat(items, ' ')
    vim.schedule(function()
      vim.api.nvim__redraw { buf = bufnr, statusline = true }
    end)
  end,
})

vim.o.statusline = [[ %<%f %h%w%m%r %=%(%{get(b:, 'diagnostic_status', '')} %)]]
