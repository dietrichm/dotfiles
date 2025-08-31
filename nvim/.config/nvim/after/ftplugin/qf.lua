vim.opt_local.cursorlineopt = 'both'
vim.opt_local.number = false
vim.opt_local.showbreak = '    '
vim.opt_local.signcolumn = 'auto'
vim.opt_local.statusline = [[ %t%<%( %{get(w:, 'quickfix_title', '')}%) %=%l/%L ]]
vim.opt_local.wrap = false

local is_loclist = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].loclist == 1
local function nmap(lhs, rhs)
  vim.keymap.set('n', lhs, rhs, { buffer = true })
end

if is_loclist then
  nmap("'", [[:Lfilter ]])
  nmap('!', [[:Lfilter! ]])
  nmap('^', [[:Lfilter ^]])
  nmap('u', [[:lolder<CR>]])
else
  nmap("'", [[:Cfilter ]])
  nmap('!', [[:Cfilter! ]])
  nmap('^', [[:Cfilter ^]])
  nmap('u', [[:colder<CR>]])
end

nmap('<C-v>', function()
  local switchbuf_old = vim.o.switchbuf
  local index = vim.fn.line('.')
  vim.cmd.wincmd('p')
  vim.cmd.vsplit()
  vim.o.switchbuf = 'uselast'
  if is_loclist then
    vim.cmd.ll(index)
  else
    vim.cmd.cc(index)
  end
  vim.o.switchbuf = switchbuf_old
end)

if vim.w.quickfix_title ~= nil then
  local grepprg = vim.o.grepprg:gsub('%-', '%%-')
  vim.w.quickfix_title = vim.w.quickfix_title:gsub(grepprg, 'grep')
end
