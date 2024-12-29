vim.opt_local.matchpairs:remove('<:>')
vim.opt_local.includeexpr = [[substitute(v:fname, '^/', '', '')]]
vim.bo.commentstring = '// %s'
vim.b.delimitMate_matchpairs = '(:),[:],{:}'

vim.cmd.iabbrev('<buffer>', '<expr>', 'ns', [[substitute(tr(expand('%:p:h'), '/', '\'), '\v^.*\\\l[^\\]*\\?', '', '')]])
vim.cmd.iabbrev('<buffer>', '<expr>', 'cls', [[expand('%:t:r')]])

vim.keymap.set('n', '<Leader>af', [[:PhpFields<CR>]], { buffer = true })

vim.api.nvim_create_user_command('PhpFile', function()
  local content = [[<?php

declare(strict_types=1);

namespace ns;

class cls
{
}]]
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('i' .. content .. '<Esc>', true, false, true), 'm', false)
end, {})
