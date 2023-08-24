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
