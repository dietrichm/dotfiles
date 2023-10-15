local loaded, tree = pcall(require, 'nvim-tree')
if not loaded then
  return
end

tree.setup {
  view = {
    width = 45,
  },
  renderer = {
    icons = {
      show = {
        folder_arrow = false,
      },
    },
  },
  git = {
    ignore = false,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}

vim.keymap.set('n', '<Leader>ft', function()
  require('nvim-tree.api').tree.toggle({ find_file = true, focus = true })
end, { silent = true })
