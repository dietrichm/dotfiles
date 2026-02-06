vim.g.mapleader = vim.keycode('<Space>')
vim.g.loaded_fzf = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.cmd.packadd { 'cfilter', bang = true }
require('paq'):setup { verbose = true } {
  'echasnovski/mini.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'justinmk/vim-sneak',
  { 'knubie/vim-kitty-navigator', build = 'cp pass_keys.py get_layout.py ' .. vim.fs.normalize('$HOME/.config/kitty') },
  'lewis6991/gitsigns.nvim',
  'MunifTanjim/nui.nvim',
  'neovim/nvim-lspconfig',
  'nvim-lua/plenary.nvim',
  { 'nvim-treesitter/nvim-treesitter', branch = 'master', build = ':TSUpdate' },
  'nvim-treesitter/nvim-treesitter-context',
  { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master' },
  { 'olimorris/codecompanion.nvim', branch = 'v18.3.1', opt = true },
  'savq/paq-nvim',
  'stevearc/conform.nvim',
  'stevearc/oil.nvim',
  'ThePrimeagen/refactoring.nvim',
  'tpope/vim-surround',
  'vim-test/vim-test',
  'Wansmer/treesj',
  'windwp/nvim-ts-autotag',
  { 'yetone/avante.nvim', branch = 'v0.0.27', opt = true, build = 'make' },
  { 'zbirenbaum/copilot.lua', opt = true },
}
-- Sort in {...} selection using :sort /[a-z-\/]\+/ ri.

vim.opt.colorcolumn = { '+1' }
vim.opt.cpoptions:append { Z = true }
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.exrc = true
vim.opt.fileformats = 'unix'
vim.opt.grepprg = 'rg --color=never --no-heading --with-filename --line-number --column'
vim.opt.guicursor:append('a:Cursor')
vim.opt.guicursor:append('a:blinkon500-blinkoff500')
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '▏ ', extends = '»', precedes = '«', trail = '·', nbsp = '␣' }
vim.opt.number = true
vim.opt.ruler = false
vim.opt.scrolloff = 2
vim.opt.shortmess:append { I = true }
vim.opt.showmode = true
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.spelllang = 'en_gb'
vim.opt.switchbuf = 'useopen,uselast'
vim.opt.timeoutlen = 3000
vim.opt.title = true
vim.opt.titlestring = 'nvim ' .. vim.fs.basename(vim.env.PWD)
vim.opt.undofile = true
vim.opt.winborder = 'rounded'

if vim.fn.has('nvim-0.12') == 1 then
  vim.opt.statusline:prepend(' ')
  require('vim._core.ui2').enable {}
end

vim.g.health = { style = 'float' }
vim.g.qf_disable_statusline = 1
vim.g['sneak#label'] = 1
vim.g['sneak#use_ic_scs'] = 1
vim.g['test#neovim#start_normal'] = 1
vim.g['test#neovim#term_position'] = 'botright 15'
vim.g['test#strategy'] = 'neovim'

vim.api.nvim_create_user_command('LspInfo', [[:checkhealth vim.lsp]], {})
vim.api.nvim_create_user_command('Nw', [[:noautocmd w]], {})
vim.api.nvim_create_user_command('Nwa', [[:noautocmd wa]], {})

require('dotfiles.colorscheme')
require('dotfiles.autocmds')
require('dotfiles.diagnostics')
require('dotfiles.completion')
require('dotfiles.ai')
require('dotfiles.treesitter')
require('dotfiles.formatters')
require('dotfiles.mini')
require('dotfiles.gitsigns')
require('dotfiles.fs')
require('dotfiles.refactoring')
require('dotfiles.skeletons')
require('dotfiles.mappings')
