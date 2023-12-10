local loaded, oil = pcall(require, 'oil')
if not loaded then
  return
end

oil.setup {
  view_options = {
    show_hidden = true,
  },
}

vim.keymap.set('n', '-', [[:Oil<CR>]], { silent = true })
