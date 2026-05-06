if vim.fn.has('nvim-0.12') ~= 1 then
  vim.notify('This configuration requires Neovim 0.12 or later.', vim.log.levels.ERROR)
  return
end

vim.g.mapleader = vim.keycode('<Space>')
vim.g.loaded_fzf = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.colorcolumn = { '+1' }
vim.opt.complete:remove('t')
vim.opt.completeopt = { 'menu', 'menuone', 'popup', 'noinsert', 'fuzzy' }
vim.opt.cpoptions:append { Z = true }
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.exrc = true
vim.opt.foldlevelstart = 99
vim.opt.grepprg = 'rg --color=never --no-heading --with-filename --line-number --column'
vim.opt.guicursor:append('a:Cursor')
vim.opt.guicursor:append('a:blinkon500-blinkoff500')
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '▏ ', extends = '»', precedes = '«', trail = '·', nbsp = '␣' }
vim.opt.number = true
vim.opt.pummaxwidth = 100
vim.opt.pumwidth = 20
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

if vim.o.statusline:sub(1, 1) ~= ' ' then
  vim.opt.statusline:prepend(' ')
end

require('vim._core.ui2').enable()
vim.cmd.packadd { 'cfilter', bang = true }
vim.pack.add {
  'https://github.com/justinmk/vim-sneak',
  'https://github.com/knubie/vim-kitty-navigator',
  'https://github.com/lewis6991/async.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/ThePrimeagen/refactoring.nvim',
  'https://github.com/tpope/vim-surround',
  'https://github.com/vim-test/vim-test',
  'https://github.com/Wansmer/treesj',
  'https://github.com/windwp/nvim-ts-autotag',
}

vim.g.qf_disable_statusline = 1
vim.g['sneak#label'] = 1
vim.g['sneak#use_ic_scs'] = 1
vim.g['test#neovim#start_normal'] = 1
vim.g['test#neovim#term_position'] = 'botright 15'
vim.g['test#strategy'] = 'neovim'

vim.api.nvim_create_user_command('Grep', [[:silent grep! <args>]], { nargs = '+', complete = 'file' })
vim.api.nvim_create_user_command('LspInfo', [[:checkhealth vim.lsp]], {})
vim.api.nvim_create_user_command('Nw', [[:noautocmd w]], {})
vim.api.nvim_create_user_command('Nwa', [[:noautocmd wa]], {})
vim.api.nvim_create_user_command('Only', [[:only | :e <args>]], { nargs = 1, complete = 'file' })
vim.api.nvim_create_user_command('PackUpdate', [[:lua vim.pack.update()]], {})
vim.api.nvim_create_user_command('PhpstanBaseline', [[:silent lgrep %:. phpstan-baseline.neon]], {})

require('dotfiles.colorscheme')
require('dotfiles.autocmds')
require('dotfiles.diagnostics')
require('dotfiles.ai')
require('dotfiles.treesitter')
require('dotfiles.formatters')
require('dotfiles.mini')
require('dotfiles.gitsigns')
require('dotfiles.fs')
require('dotfiles.refactoring')
require('dotfiles.skeletons')
require('dotfiles.mappings')
