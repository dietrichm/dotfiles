local loaded, telescope = pcall(require, 'telescope')
if not loaded then
  return
end

local actions = require('telescope.actions')
local actions_layout = require('telescope.actions.layout')

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
