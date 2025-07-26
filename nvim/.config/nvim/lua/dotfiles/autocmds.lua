local augroup = vim.api.nvim_create_augroup('dotfiles_autocmds', { clear = true })

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'grep',
  group = augroup,
  command = [[botright cwindow]],
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'lgrep',
  group = augroup,
  command = [[lwindow]],
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'lmake',
  group = augroup,
  callback = function()
    vim.cmd([[
      lwindow
      if getloclist(0, {'size': 1}).size == 0
        unsilent echomsg "✅ No errors"
      endif
    ]])
  end,
})

---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  group = augroup,
  callback = function()
    vim.hl.on_yank {
      higroup = 'Visual',
      timeout = 500,
      on_visual = false,
    }
  end,
})
