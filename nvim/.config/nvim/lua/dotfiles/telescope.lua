local loaded, telescope = pcall(require, 'telescope')
if not loaded then
  return
end

local actions = require('telescope.actions')
local actions_layout = require('telescope.actions.layout')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = {
        height = 0.8,
        preview_width = { 0.49, min = 80 },
        prompt_position = 'top',
        width = 0.8,
      },
    },
    preview = {
      hide_on_startup = true,
    },
    mappings = {
      i = {
        ['<Esc>'] = actions.close,
        ['<M-p>'] = actions_layout.toggle_preview,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      sort_mru = true,
    },
    oldfiles = {
      only_cwd = true,
    },
  },
}

telescope.load_extension('fzf')

local map = vim.keymap.set

map('n', '<Leader>o', builtin.find_files)
map('n', '<Leader>O', function()
  builtin.find_files { no_ignore = true }
end)
map('n', '<Leader>b', builtin.buffers)
map('n', '<Leader>fh', builtin.oldfiles)
map('n', '<Leader>tr', builtin.resume)
