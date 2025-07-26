local loaded, oil = pcall(require, 'oil')
if not loaded then
  return
end

oil.setup {
  columns = {
    { 'permissions', highlight = 'Comment' },
    { 'size', highlight = 'Number' },
  },
  view_options = {
    show_hidden = true,
  },
  git = {
    mv = function()
      return true
    end,
  },
  keymaps = {
    ['<C-s>'] = 'actions.select_split',
    ['<C-v>'] = 'actions.select_vsplit',
    ['q'] = 'actions.close',
    ['<C-r>'] = 'actions.refresh',
    ['<M-p>'] = 'actions.preview',
  },
}

vim.keymap.set('n', '-', oil.open)
