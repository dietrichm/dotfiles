require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'css',
    'go',
    'html',
    'javascript',
    'json',
    'markdown',
    'php',
    'python',
    'toml',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'php' },
  },
}
