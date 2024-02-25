local loaded, treesitter = pcall(require, 'nvim-treesitter.configs')
if not loaded then
  return
end

treesitter.setup {
  ensure_installed = {
    'bash',
    'css',
    'dockerfile',
    'go',
    'html',
    'javascript',
    'json',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'php',
    'python',
    'scss',
    'toml',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {
      -- Required for indentation rules.
      'php',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      include_surrounding_whitespace = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      },
    },
  },
}

local treesj = require('treesj')

treesj.setup {
  use_default_keymaps = false,
}

vim.keymap.set('n', '<Leader>x', treesj.toggle, { silent = true })
