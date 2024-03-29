local loaded, oil = pcall(require, 'oil')
if not loaded then
  return
end

oil.setup {
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ['<C-s>'] = false,
    ['<C-v>'] = 'actions.select_vsplit',
    ['<C-h>'] = false,
    ['<C-x>'] = 'actions.select_split',
    ['<C-c>'] = false,
    ['q'] = 'actions.close',
    ['<C-l>'] = false,
    ['<C-r>'] = 'actions.refresh',
    ['<C-p>'] = false,
    ['<M-p>'] = 'actions.preview',
  },
}

vim.keymap.set('n', '-', [[:Oil<CR>]], { silent = true })
