local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end
local augroup = vim.api.nvim_create_augroup('vimrc', { clear = true })

-- Leader.
vim.g.mapleader = ' '
map('n', '<Space>', '')

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

  -- UI and colours.
  'justinmk/molokai',

  -- Editing.
  'neovim/nvim-lspconfig',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  'Raimondi/delimitMate',
  'tpope/vim-surround',
  'tpope/vim-commentary',
  'alvan/vim-closetag',
  'justinmk/vim-sneak',
  'mhartington/formatter.nvim',
  'Wansmer/treesj',

  -- Completion.
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',

  -- Git.
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',

  -- Development.
  'vim-test/vim-test',
  {
    'fatih/vim-go',
    build = ':GoUpdateBinaries',
  },
  'pangloss/vim-javascript',
  'HerringtonDarkholme/yats.vim',
  'Vimjas/vim-python-pep8-indent',
  'jwalton512/vim-blade',
}

-- Options.
vim.opt.scrolloff = 2
vim.opt.number = true
vim.opt.fileformats = 'unix'
vim.opt.showmode = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.linebreak = true
vim.opt.title = true
vim.opt.titlestring = [[nvim in %{substitute(getcwd(), '.*/', '', '')}]]
vim.opt.list = true
vim.opt.listchars = { tab = '→ ', extends = '»', precedes = '«', trail = '▒', nbsp = '·' }
vim.opt.shortmess:append({ I = true })
vim.opt.spelllang = 'en_gb'
vim.opt.grepprg = [[rg --vimgrep]]
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.exrc = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.colorcolumn = { '+1' }
vim.opt.guicursor:append('a:blinkon500-blinkoff500')

-- Disable various plugins and providers.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_fzf = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- Configure PHP syntax.
vim.g.PHP_noArrowMatching = 1

-- Configure delimitMate.
vim.g.delimitMate_excluded_ft = 'TelescopePrompt'
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
    'typescript',
  },
  group = augroup,
  callback = function()
    vim.b.delimitMate_expand_space = 1
    vim.b.delimitMate_expand_cr = 1
  end,
})

-- Configure vim-closetag.
vim.g.closetag_filetypes = 'html,xhtml,phtml,blade,gohtmltmpl'

-- Configure vim-test.
vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'botright 15'
map('n', '<Leader>rc', [[:noautocmd update | :TestFile<CR>]])
map('n', '<Leader>rt', [[:noautocmd update | :TestNearest<CR>]])
map('n', '<Leader>rr', [[:noautocmd update | :TestLast<CR>]])

-- Configure vim-go.
vim.g.go_code_completion_enabled = 0
vim.g.go_def_mapping_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_fmt_fail_silently = 1
vim.g.go_imports_autosave = 0
vim.g.go_jump_to_error = 0

-- Diagnostics.
if vim.fn.has('nvim-0.10') == 1 then
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '❌',
        [vim.diagnostic.severity.WARN] = '❗',
        [vim.diagnostic.severity.INFO] = '💡',
        [vim.diagnostic.severity.HINT] = '💭',
      },
    },
  })
else
  vim.fn.sign_define('DiagnosticSignError', { text = '❌' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = '❗' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = '💡' })
  vim.fn.sign_define('DiagnosticSignHint', { text = '💭' })
end
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<Leader>q', vim.diagnostic.setloclist)

-- Enable search highlight when searching for symbols.
map('n', '*', [[:setlocal hlsearch | :normal! *<CR>]])
map('n', '#', [[:setlocal hlsearch | :normal! #<CR>]])
map('n', 'g*', [[:setlocal hlsearch | :normal! g*<CR>]])
map('n', 'g#', [[:setlocal hlsearch | :normal! g#<CR>]])

-- Toggle search highlight.
map('n', '\\', [[:setlocal hlsearch!<CR>]])

-- Up and down by visible lines.
vim.keymap.set('n', 'j', [[v:count == 0 ? 'gj' : 'j']], { silent = true, expr = true })
vim.keymap.set('n', 'k', [[v:count == 0 ? 'gk' : 'k']], { silent = true, expr = true })

-- Paragraph motions do not change jumplist.
map('n', '}', [[:keepjumps normal! }<CR>]])
map('n', '{', [[:keepjumps normal! {<CR>]])

-- Move through quickfix and location list.
map('n', ']q', [[:cnext<CR>]])
map('n', '[q', [[:cprevious<CR>]])
map('n', ']Q', [[:clast<CR>]])
map('n', '[Q', [[:cfirst<CR>]])
map('n', ']l', [[:lnext<CR>]])
map('n', '[l', [[:lprevious<CR>]])
map('n', ']L', [[:llast<CR>]])
map('n', '[L', [[:lfirst<CR>]])

-- Delete all buffers.
map('n', '<Leader>da', [[:%bd<CR>]])

-- Terminals.
map('t', '<Esc>', [[<C-\><C-n>]])
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  group = augroup,
  callback = function()
    vim.opt_local.number = false
  end,
})

-- Path copy mappings.
map('n', '<Leader>pc', [[:let @+ = expand('%:.')<CR>]])
map('n', '<Leader>pC', [[:let @+ = expand('%:.') . ":" . line(".")<CR>]])
map('n', '<Leader>Pc', [[:let @+ = expand('%:p:~')<CR>]])

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

-- Write without triggering autocommands.
vim.api.nvim_create_user_command('Nw', [[:noautocmd w]], {})
vim.api.nvim_create_user_command('Nwa', [[:noautocmd wa]], {})
