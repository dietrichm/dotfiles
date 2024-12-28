local loaded, treesitter = pcall(require, 'nvim-treesitter.configs')
if not loaded then
  return
end

vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

treesitter.setup {
  auto_install = true,
  ensure_installed = {
    'css',
    'html',
    'javascript',
    'markdown',
    'markdown_inline',
    'yaml',
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      include_surrounding_whitespace = false,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
      },
      selection_modes = {
        ['@function.outer'] = 'V',
        ['@function.inner'] = 'V',
        ['@parameter.outer'] = 'v',
        ['@parameter.inner'] = 'v',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
      },
    },
  },
}

local treesj = require('treesj')

treesj.setup {
  use_default_keymaps = false,
  max_join_length = 200,
}

vim.keymap.set('n', '<Leader>x', treesj.toggle, { silent = true })

require('treesitter-context').setup {
  enable = false,
  multiline_threshold = 7,
}
