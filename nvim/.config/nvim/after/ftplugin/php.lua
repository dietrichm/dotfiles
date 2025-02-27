vim.opt_local.matchpairs:remove('<:>')
vim.opt_local.includeexpr = [[substitute(v:fname, '^/', '', '')]]
vim.bo.commentstring = '// %s'

vim.cmd.iabbrev('<buffer>', '<expr>', 'ns', [[substitute(tr(expand('%:p:h'), '/', '\'), '\v^.*\\\l[^\\]*\\?', '', '')]])
vim.cmd.iabbrev('<buffer>', '<expr>', 'cls', [[expand('%:t:r')]])

vim.keymap.set('n', '<Leader>af', _G.PhpFields, { buffer = true })

vim.api.nvim_buf_create_user_command(0, 'PhpFile', function()
  local content = [[<?php

declare(strict_types=1);

namespace ns;

final class cls
{
}]]
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('i' .. content .. '<Esc>', true, false, true), 'm', false)
end, {})
