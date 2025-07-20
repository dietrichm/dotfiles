local augroup = vim.api.nvim_create_augroup('dotfiles_init', { clear = true })

vim.g.mapleader = ' '
vim.g.loaded_fzf = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

require('paq'):setup { verbose = true } {
  'echasnovski/mini.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'justinmk/vim-sneak',
  { 'knubie/vim-kitty-navigator', build = 'cp pass_keys.py get_layout.py ' .. vim.fs.normalize('$HOME/.config/kitty') },
  'lewis6991/gitsigns.nvim',
  'neovim/nvim-lspconfig',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-treesitter/nvim-treesitter', branch = 'master', build = ':TSUpdate' },
  'nvim-treesitter/nvim-treesitter-context',
  { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master' },
  'savq/paq-nvim',
  'stevearc/conform.nvim',
  'stevearc/oil.nvim',
  'ThePrimeagen/refactoring.nvim',
  'tpope/vim-surround',
  'vim-test/vim-test',
  'Wansmer/treesj',
  'windwp/nvim-ts-autotag',
  { 'zbirenbaum/copilot.lua', opt = true },
}
-- Sort in {...} selection using :sort /[a-z-\/]\+/ ri.

vim.opt.colorcolumn = { '+1' }
vim.opt.cpoptions:append { Z = true }
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.exrc = true
vim.opt.fileformats = 'unix'
vim.opt.grepprg = 'rg --vimgrep'
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
vim.opt.timeoutlen = 3000
vim.opt.title = true
vim.opt.titlestring = 'nvim ' .. vim.fs.basename(vim.env.PWD)
vim.opt.undofile = true

if vim.env.NVIM_EXTUI == '1' and vim.fn.has('nvim-0.12') == 1 then
  require('vim._extui').enable {}
end

vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'botright 15'
vim.g['test#neovim#start_normal'] = 1

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'grep',
  group = augroup,
  command = [[cwindow]],
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'lmake',
  group = augroup,
  callback = function()
    vim.cmd([[
      lwindow
      if getloclist(0, {'size': 1}).size == 0
        unsilent echomsg "✅ No errors"
      endif
    ]])
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  group = augroup,
  callback = function()
    vim.hl.on_yank {
      higroup = 'Visual',
      timeout = 500,
      on_visual = false,
    }
  end,
})

vim.api.nvim_create_user_command('Rgi', [[:grep<bang> --no-ignore-vcs <args>]], { nargs = '+', bang = true })
vim.api.nvim_create_user_command('Nw', [[:noautocmd w]], {})
vim.api.nvim_create_user_command('Nwa', [[:noautocmd wa]], {})

require('dotfiles.colorscheme')
require('dotfiles.editing')
require('dotfiles.diagnostics')
require('dotfiles.lsp')
require('dotfiles.completion')
require('dotfiles.copilot')
require('dotfiles.treesitter')
require('dotfiles.formatters')
require('dotfiles.telescope')
require('dotfiles.gitsigns')
require('dotfiles.fs')
require('dotfiles.refactoring')
require('dotfiles.skeletons')
require('dotfiles.statusline')
require('dotfiles.mappings')
