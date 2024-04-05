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
    find_files = {
      hidden = true,
    },
    buffers = {
      sort_mru = true,
    },
    oldfiles = {
      only_cwd = true,
    },
    current_buffer_tags = {
      show_line = true,
    },
    tagstack = {
      fname_width = 80,
    },
    lsp_implementations = {
      fname_width = 80,
    },
    lsp_references = {
      fname_width = 80,
      include_declaration = false,
    },
    lsp_type_definitions = {
      fname_width = 80,
    },
    lsp_document_symbols = {
      symbol_width = 60,
      symbol_type_width = 10,
      show_line = true,
      ignore_symbols = { 'variable', 'property' },
    },
  },
}

telescope.load_extension('fzf')

local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

map('n', '<Leader>o', builtin.find_files)
map('n', '<Leader>O', function()
  builtin.find_files({ no_ignore = true })
end)
map('n', '<Leader>b', builtin.buffers)
map('n', '<Leader>fh', builtin.oldfiles)
map('n', '<Leader>fH', function()
  builtin.oldfiles({ only_cwd = false })
end)
map('n', '<Leader>sw', function()
  builtin.grep_string({ word_match = '-w' })
end)
map('n', '<Leader>tb', builtin.current_buffer_tags)
map('n', '<Leader>ts', builtin.tagstack)
map('n', '<Leader>tr', builtin.resume)

map('n', '<Leader>fs', function()
  local file_root = vim.fn.expand('%:t:r')
  local file_root_without_test = vim.fn.substitute(file_root, '_\\?test$\\c', '', '')
  builtin.find_files({ search_file = file_root_without_test })
end)

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
      end,
    })
  end
end

vim.api.nvim_create_user_command('Rg', rg({}), { nargs = '*' })
vim.api.nvim_create_user_command('Rgi', rg({ '--no-ignore-vcs' }), { nargs = '*' })
vim.api.nvim_create_user_command('Rgw', rg({ '--word-regexp' }), { nargs = '*' })
