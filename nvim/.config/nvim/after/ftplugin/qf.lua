vim.opt_local.cursorlineopt = 'both'
vim.opt_local.number = false
vim.opt_local.showbreak = '    '
vim.opt_local.signcolumn = 'auto'
vim.opt_local.statusline = [[ %t%<%( %{get(w:, 'quickfix_title', '')}%) %=%l/%L ]]
vim.opt_local.wrap = false

local winid = vim.api.nvim_get_current_win()
local function nmap(lhs, rhs)
  vim.keymap.set('n', lhs, rhs, { buffer = true })
end

if vim.fn.getwininfo(winid)[1].loclist == 1 then
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

if vim.w.quickfix_title ~= nil then
  local grepprg = vim.o.grepprg:gsub('%-', '%%-')
  vim.w.quickfix_title = vim.w.quickfix_title:gsub(grepprg, 'grep')
end
