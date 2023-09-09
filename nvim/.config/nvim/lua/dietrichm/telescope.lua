local telescope = require('telescope')
local actions = require('telescope.actions')
local actions_layout = require('telescope.actions.layout')
local builtin = require('telescope.builtin')

telescope.setup {
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
  },
  pickers = {
    lsp_implementations = {
      fname_width = 80,
    },
    lsp_references = {
      fname_width = 80,
    },
    lsp_document_symbols = {
      show_line = true,
    },
  },
}

telescope.load_extension('fzf')

local opts = { silent = true }

vim.keymap.set('n', '<Leader>o', function() builtin.find_files({ hidden = true }) end, opts)
vim.keymap.set('n', '<Leader>O', function() builtin.find_files({ hidden = true, no_ignore = true }) end, opts)
vim.keymap.set('n', '<Leader>b', builtin.buffers, opts)
vim.keymap.set('n', '<Leader>fh', builtin.oldfiles, opts)
vim.keymap.set('n', '<Leader>sw', function() builtin.grep_string({ word_match = '-w' }) end, opts)
vim.keymap.set('n', '<Leader>tb', function()
  builtin.lsp_document_symbols({ ignore_symbols = { 'variable', 'property' } })
end, opts)

local function rg(add_options)
  return function(options)
    builtin.grep_string({
      search = options.args,
      use_regex = true,
      additional_args = function(rg_options)
        for _, add_option in ipairs(add_options) do
          table.insert(rg_options, add_option)
        end
        return rg_options
      end
    })
  end
end

vim.api.nvim_create_user_command(
  'Rg',
  rg({}),
  { nargs = '*' }
)

vim.api.nvim_create_user_command(
  'Rgi',
  rg({ '--no-ignore-vcs' }),
  { nargs = '*' }
)

vim.api.nvim_create_user_command(
  'Rgw',
  rg({ '--word-regexp' }),
  { nargs = '*' }
)
