vim.cmd([[
  let s:vim_plug_script = stdpath('data') . '/site/autoload/plug.vim'
  if empty(glob(s:vim_plug_script))
    execute '!curl -fLo ' . shellescape(s:vim_plug_script) . ' --create-dirs '
      \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
]])

local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end
local augroup = vim.api.nvim_create_augroup('vimrc', { clear = true })

-- Leader.
vim.g.mapleader = ' '
map('n', '<Space>', '')

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
Plug 'justinmk/molokai'

-- Editing.
Plug 'neovim/nvim-lspconfig'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'alvan/vim-closetag'
Plug 'justinmk/vim-sneak'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'mhartington/formatter.nvim'

-- Completion.
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

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

-- Disable netrw and providers.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
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
  end
})

-- Configure vim-closetag.
vim.g.closetag_filetypes = 'html,xhtml,phtml,blade'

-- Configure splitjoin.vim.
vim.g.splitjoin_php_method_chain_full = 1

-- Configure vim-test.
vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'botright 15'
map('n', '<Leader>rc', [[:update | :TestFile<CR>]])
map('n', '<Leader>rt', [[:update | :TestNearest<CR>]])
map('n', '<Leader>rr', [[:update | :TestLast<CR>]])

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
vim.keymap.set('n', 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
vim.keymap.set('n', 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

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
  end
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
  end
})

-- Global abbreviations.
vim.cmd.iabbrev('<expr>', 'uuid', [[luaeval('io.open("/proc/sys/kernel/random/uuid"):read()')]])

-- Write without triggering autocommands.
vim.api.nvim_create_user_command('Nw', [[:noautocmd w]], {})
vim.api.nvim_create_user_command('Nwa', [[:noautocmd wa]], {})
