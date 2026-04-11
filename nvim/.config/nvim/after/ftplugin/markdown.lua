if vim.bo.buftype == 'nofile' then
  return
end

vim.opt_local.spell = true
vim.cmd.compiler('markdown')

-- Wrap visual selection in link.
vim.keymap.set('v', '<Leader>cl', '<Plug>VSurround]%a(', { buf = 0, remap = true })

-- Surround text with `*` places double asterisks.
vim.b.surround_42 = '**\r**'
