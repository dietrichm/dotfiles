local telescope = require('telescope')
local actions = require('telescope.actions')
local actions_layout = require('telescope.actions.layout')

telescope.setup{
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = {
        height = 0.8,
        preview_cutoff = 120,
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
  }
}

telescope.load_extension('fzf')

local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', '<Leader>o',
  [[<cmd>lua require('telescope.builtin').find_files({hidden=true, no_ignore=true})<CR>]], opts)
vim.api.nvim_set_keymap('n', '<Leader>b',
  [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<Leader>fh',
  [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<Leader>sw',
  [[<cmd>lua require('telescope.builtin').grep_string({word_match='-w'})<CR>]], opts)
vim.api.nvim_set_keymap('n', '<Leader>tb',
  [[<cmd>lua require('telescope.builtin').lsp_document_symbols({ignore_symbols={'variable'}})<CR>]], opts)
