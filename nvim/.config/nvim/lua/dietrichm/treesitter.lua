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
      'php',
      'markdown',
    },
  },
}

local treesj = require('treesj')

treesj.setup {
  use_default_keymaps = false,
}

vim.keymap.set('n', '<Leader>x', treesj.toggle, { silent = true })
