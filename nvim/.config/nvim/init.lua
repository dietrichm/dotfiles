local augroup = vim.api.nvim_create_augroup('dotfiles_init', { clear = true })

vim.g.mapleader = ' '

require('paq'):setup { verbose = true } {
  'savq/paq-nvim',

  -- Tools.
  'nvim-telescope/telescope.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  'stevearc/oil.nvim',
  'nvim-lua/plenary.nvim',
  {
    'knubie/vim-kitty-navigator',
    build = 'cp pass_keys.py get_layout.py ' .. vim.fn.expand('$MY_CONFIG_ROOT/kitty/.config/kitty'),
  },

  -- Editing.
  'neovim/nvim-lspconfig',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/nvim-treesitter-context',
  'Raimondi/delimitMate',
  'tpope/vim-surround',
  'alvan/vim-closetag',
  'justinmk/vim-sneak',
  'stevearc/conform.nvim',
  'Wansmer/treesj',
  'folke/zen-mode.nvim',

  -- Completion.
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',

  -- Git.
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',

  -- Development.
  'vim-test/vim-test',
  'ThePrimeagen/refactoring.nvim',
}

-- Options.
vim.opt.scrolloff = 2
vim.opt.number = true
vim.opt.fileformats = 'unix'
vim.opt.showmode = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.linebreak = true
vim.opt.title = false
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

-- Configure vim-closetag.
vim.g.closetag_filetypes = 'html,xhtml,phtml,blade,twig'

-- Configure delimitMate.
vim.g.delimitMate_excluded_ft = 'TelescopePrompt'
vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.g.closetag_filetypes,
  group = augroup,
  callback = function()
    -- Remove angled brackets.
    vim.b.delimitMate_matchpairs = '(:),[:],{:}'
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'css',
    'go',
    'javascript',
    'json',
    'lua',
    'php',
    'python',
    'scss',
    'sh',
    'twig',
    'typescript',
  },
  group = augroup,
  callback = function()
    vim.b.delimitMate_expand_space = 1
    vim.b.delimitMate_expand_cr = 1
  end,
})

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

-- Write without triggering autocommands.
vim.api.nvim_create_user_command('Nw', [[:noautocmd w]], {})
vim.api.nvim_create_user_command('Nwa', [[:noautocmd wa]], {})

-- Aliases for writing.
vim.api.nvim_create_user_command('W', [[:w]], {})
vim.api.nvim_create_user_command('Wa', [[:wa]], {})
