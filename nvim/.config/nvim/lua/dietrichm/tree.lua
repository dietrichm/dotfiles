require('nvim-tree').setup {
  view = {
    width = 45,
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

require('nvim-tree.view').View.winopts.signcolumn = 'auto'

vim.keymap.set('n', '<Leader>ft', function()
  require('nvim-tree.api').tree.toggle({ find_file = true, focus = true })
end, { silent = true })
