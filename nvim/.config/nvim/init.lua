local kitty_config = vim.fn.expand('$MY_CONFIG_ROOT/kitty/.config/kitty')
local augroup = vim.api.nvim_create_augroup('dotfiles_init', { clear = true })

vim.g.mapleader = ' '

require('paq'):setup { verbose = true } {
  'echasnovski/mini.nvim',
  'folke/zen-mode.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'justinmk/vim-sneak',
  { 'knubie/vim-kitty-navigator', build = 'cp pass_keys.py get_layout.py ' .. kitty_config },
  'lewis6991/gitsigns.nvim',
  'neovim/nvim-lspconfig',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'savq/paq-nvim',
  'stevearc/conform.nvim',
  'stevearc/oil.nvim',
  'ThePrimeagen/refactoring.nvim',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'vim-test/vim-test',
  'Wansmer/treesj',
}
-- Sort in {...} selection using :sort /[a-z-\/]\+/ ri.

-- Options.
vim.opt.scrolloff = 2
vim.opt.number = true
vim.opt.fileformats = 'unix'
vim.opt.showmode = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.linebreak = true
vim.opt.title = true
vim.opt.titlestring = 'nvim ' .. vim.fn.substitute(vim.env.PWD, '.*/', '', '')
vim.opt.list = true
vim.opt.listchars = {
  tab = '▏ ',
  extends = '»',
  precedes = '«',
  trail = '·',
  nbsp = '␣',
}
vim.opt.shortmess:append({ I = true })
vim.opt.spelllang = 'en_gb'
vim.opt.undofile = true
vim.opt.exrc = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.colorcolumn = { '+1' }
vim.opt.guicursor:append('a:blinkon500-blinkoff500')
vim.opt.guicursor:append('a:Cursor')
vim.opt.signcolumn = 'yes'

-- Disable various standard plugins and providers.
vim.g.loaded_fzf = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Configure vim-test.
vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'botright 15'

-- Auto open quickfix for make.
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'make*',
  group = augroup,
  nested = true,
  command = [[cwindow]],
})

-- Terminals.
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  group = augroup,
  callback = function()
    if vim.fn.has('nvim-0.11') == 0 then
      vim.opt_local.number = false
      vim.opt_local.signcolumn = 'auto'
    end
    vim.opt_local.statusline = [[ %{b:term_title} ]]
  end,
})

-- Yank highlighting.
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end,
})

-- Global abbreviations.
vim.cmd.iabbrev('<expr>', 'ruuid', [[luaeval('io.open("/proc/sys/kernel/random/uuid"):read()')]])
vim.cmd.iabbrev('<expr>', 'ctime', [[luaeval('os.date("%FT%T%z")')]])
vim.cmd.cabbrev('w;', 'w')

-- Write without triggering autocommands.
vim.api.nvim_create_user_command('Nw', [[:noautocmd w]], {})
vim.api.nvim_create_user_command('Nwa', [[:noautocmd wa]], {})

-- Aliases for writing.
vim.api.nvim_create_user_command('W', [[:w]], {})
vim.api.nvim_create_user_command('Wa', [[:wa]], {})
