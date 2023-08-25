vim.cmd([[
  let s:vim_plug_script = stdpath('data') . '/site/autoload/plug.vim'
  if empty(glob(s:vim_plug_script))
    execute '!curl -fLo ' . shellescape(s:vim_plug_script) . ' --create-dirs '
      \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
]])

local keymap_opts = { silent = true }
local augroup = vim.api.nvim_create_augroup('vimrc', { clear = true })

-- Leader.
vim.g.mapleader = ' '
vim.keymap.set('n', '<Space>', '', keymap_opts)

vim.fn['plug#begin']()
local Plug = vim.fn['plug#']

-- Tools.
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lua/plenary.nvim'
Plug('knubie/vim-kitty-navigator',
  { ['do'] = 'cp ./*.py ' .. vim.fn.shellescape(vim.fn.expand('$MY_CONFIG_ROOT/kitty/.config/kitty')) })

-- UI and colours.
Plug 'chriskempson/base16-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'justinmk/molokai'

-- Editing.
Plug 'SirVer/ultisnips'
Plug 'neovim/nvim-lspconfig'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'alvan/vim-closetag'
Plug 'justinmk/vim-sneak'
Plug 'AndrewRadev/splitjoin.vim'

-- Completion.
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

-- Git.
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

-- Development.
Plug 'vim-test/vim-test'
if vim.fn.executable('go') then
  Plug('fatih/vim-go', { ['do'] = ':GoUpdateBinaries' })
end
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jwalton512/vim-blade'

vim.fn['plug#end']()

-- Options.
vim.opt.scrolloff = 2
vim.opt.number = true
vim.opt.numberwidth = 1
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
vim.opt.updatetime = 100
vim.opt.shortmess:append({ c = true, I = true, W = true })
vim.opt.spelllang = 'en_gb'
vim.opt.path = { '.', '*' }
vim.opt.grepprg = [[rg --vimgrep]]
vim.opt.undofile = true
vim.opt.signcolumn = 'auto:1-2'
vim.opt.termguicolors = true
vim.opt.exrc = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- Configure PHP syntax.
vim.g.PHP_noArrowMatching = 1

-- Configure delimitMate.
vim.g.delimitMate_excluded_ft = 'TelescopePrompt'
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'css',
    'go',
    'javascript',
    'lua',
    'php',
    'python',
    'sh',
    'typescript',
  },
  group = augroup,
  callback = function()
    vim.b.delimitMate_expand_space = 1
    vim.b.delimitMate_expand_cr = 1
  end
})

-- Configure vim-closetag.
vim.g.closetag_filetypes = 'html,xhtml,phtml,blade'

-- Configure splitjoin.vim.
vim.g.splitjoin_php_method_chain_full = 1

-- Configure UltiSnips.
vim.g.UltiSnipsSnippetsDir = vim.fn.stdpath('config') .. '/UltiSnips'
vim.g.UltiSnipsEditSplit = 'context'

-- Configure vim-test.
vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'botright 15'
vim.keymap.set('n', '<Leader>rc', [[:update | :TestFile<CR>]], keymap_opts)
vim.keymap.set('n', '<Leader>rt', [[:update | :TestNearest<CR>]], keymap_opts)
vim.keymap.set('n', '<Leader>rr', [[:update | :TestLast<CR>]], keymap_opts)

-- Configure vim-go.
vim.g.go_code_completion_enabled = 0
vim.g.go_def_mapping_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_fmt_fail_silently = 1
vim.g.go_imports_autosave = 0
vim.g.go_jump_to_error = 0

-- Diagnostics.
vim.fn.sign_define('DiagnosticSignError', { text = '❌' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '❗' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '💡' })
vim.fn.sign_define('DiagnosticSignHint', { text = '💭' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, keymap_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, keymap_opts)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, keymap_opts)

-- Enable search highlight when searching for symbols.
vim.keymap.set('n', '*', [[:setlocal hlsearch | :normal! *<CR>]], keymap_opts)
vim.keymap.set('n', '#', [[:setlocal hlsearch | :normal! #<CR>]], keymap_opts)
vim.keymap.set('n', 'g*', [[:setlocal hlsearch | :normal! g*<CR>]], keymap_opts)
vim.keymap.set('n', 'g#', [[:setlocal hlsearch | :normal! g#<CR>]], keymap_opts)

-- Toggle search highlight.
vim.keymap.set('n', '\\', [[:setlocal hlsearch!<CR>]], keymap_opts)

-- Up and down by visible lines.
vim.keymap.set('n', 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
vim.keymap.set('n', 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Paragraph motions do not change jumplist.
vim.keymap.set('n', '}', [[:keepjumps normal! }<CR>]], keymap_opts)
vim.keymap.set('n', '{', [[:keepjumps normal! {<CR>]], keymap_opts)

-- Move through quickfix and location list.
vim.keymap.set('n', ']q', [[:cnext<CR>]], keymap_opts)
vim.keymap.set('n', '[q', [[:cprevious<CR>]], keymap_opts)
vim.keymap.set('n', ']Q', [[:clast<CR>]], keymap_opts)
vim.keymap.set('n', '[Q', [[:cfirst<CR>]], keymap_opts)
vim.keymap.set('n', ']l', [[:lnext<CR>]], keymap_opts)
vim.keymap.set('n', '[l', [[:lprevious<CR>]], keymap_opts)
vim.keymap.set('n', ']L', [[:llast<CR>]], keymap_opts)
vim.keymap.set('n', '[L', [[:lfirst<CR>]], keymap_opts)

-- Use g] for :tjump.
vim.keymap.set('n', 'g]', [[g<C-]>]], keymap_opts)
vim.keymap.set('n', '<C-W>g]', [[<C-W>g<C-]>]], keymap_opts)

-- Delete all buffers.
vim.keymap.set('n', '<Leader>da', [[:%bd<CR>]], keymap_opts)

-- Terminals.
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], keymap_opts)
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.signcolumn = 'auto'
  end
})

-- Path copy mappings.
vim.keymap.set('n', '<Leader>pc', [[:let @+ = @%<CR>]], keymap_opts)
vim.keymap.set('n', '<Leader>Pc', [[:let @+ = @% . ":" . line(".")<CR>]], keymap_opts)

-- Yank highlighting.
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end
})

-- Global abbreviations.
vim.cmd.iabbrev('uuid', [[<C-R>=luaeval('io.open("/proc/sys/kernel/random/uuid"):read()')<CR>]])

-- Lua plugins.
require('dietrichm')
