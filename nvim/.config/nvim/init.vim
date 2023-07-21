scriptencoding utf-8

let s:load_line_plugins = 0
let s:load_go_plugins = executable('go') == 1

let s:vim_plug_script = stdpath('config') . '/autoload/plug.vim'
if empty(glob(s:vim_plug_script))
    execute '!curl -fLo ' . shellescape(s:vim_plug_script) . ' --create-dirs '
        \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    " vint: next-line -ProhibitAutocmdWithNoGroup
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Tools.
Plug 'junegunn/fzf', {'do': './install --all'}
Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
Plug 'kyazdani42/nvim-tree.lua'
Plug 'christoomey/vim-tmux-navigator'
Plug 'embear/vim-localvimrc'
Plug 'nvim-lua/plenary.nvim'

" UI and colours.
Plug 'chriskempson/base16-vim'
Plug 'NLKNguyen/papercolor-theme'
if s:load_line_plugins
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'edkolev/promptline.vim'
endif

" Editing.
Plug 'editorconfig/editorconfig-vim'
Plug 'SirVer/ultisnips'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'alvan/vim-closetag'

" Completion.
Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" Git.
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" Development.
Plug 'vim-test/vim-test'
if s:load_go_plugins
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
endif
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jwalton512/vim-blade'

" Other syntax.
Plug 'cespare/vim-toml', {'branch': 'main'}
Plug 'plasticboy/vim-markdown'

call plug#end()

nnoremap <Space> <Nop>
let mapleader = "\<Space>"

" General settings
set scrolloff=2
set number
set numberwidth=1
set fileformats=unix
set showmode
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set nohlsearch
set ignorecase
set smartcase
set nowrapscan
set linebreak
set title
set titlestring=%F
set listchars=tab:→\ ,extends:»,precedes:«,trail:▒,nbsp:·
set list
set updatetime=100
set shortmess+=cIW
set spelllang=en_gb
set path=.,*
set grepprg=rg\ --vimgrep
set undofile
set signcolumn=auto:1-2
set termguicolors

" Remove "disable mouse" pop-up menu item.
aunmenu PopUp.How-to\ disable\ mouse
aunmenu PopUp.-1-

" Configure nvim-tree.
nnoremap <silent> <Leader>ft :NvimTreeFindFileToggle<CR>

" Configure Localvimrc.
let g:localvimrc_persistent = 1

" Configure PHP syntax.
let g:PHP_noArrowMatching = 1

" Configure delimitMate.
let delimitMate_excluded_ft = 'TelescopePrompt'

" Configure vim-closetag.
let g:closetag_filetypes = 'html,xhtml,phtml,blade'

" Configure Airline.
let g:airline_disable_statusline = 1
let g:airline_powerline_fonts = 1
let g:airline_extensions = []

" Configure Promptline.
try
    let g:promptline_theme = 'airline_insert'
    let g:promptline_preset = {
        \ 'a': [ promptline#slices#host({ 'only_if_ssh': 1 }), promptline#slices#user() ],
        \ 'b': [ promptline#slices#cwd() ],
        \ 'c': [ '%#' ],
        \ 'x': [ promptline#slices#git_status() ],
        \ 'y': [ promptline#slices#vcs_branch(), promptline#slices#conda_env() ],
        \ 'warn': [ promptline#slices#last_exit_code() ],
        \ 'options': {
            \ 'left_sections': [ 'a', 'b', 'c' ],
            \ 'right_sections': [ 'warn', 'x', 'y' ]
        \ }
    \ }
catch
endtry

augroup terminal
    autocmd!
    autocmd TermOpen * setlocal nonumber
augroup END

augroup fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" Yank highlighting.
augroup yank
    autocmd!
    autocmd TextYankPost * lua vim.highlight.on_yank {timeout=500}
augroup END

" Configure vista.
let g:vista#renderer#enable_icon = 0
let g:vista_close_on_jump = 1
let g:vista_echo_cursor = 0
let g:vista_executive_for = {
    \ 'markdown': 'toc',
\ }
let g:vista_ignore_kinds = ['Variable', 'Unknown']
let g:vista_sidebar_width = 45

" Configure FZF.
let $FZF_DEFAULT_OPTS .= ' --reverse'
let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8}}
let g:fzf_preview_window = ['right:50%:hidden:+{2}-/2', 'ctrl-/']

" Configure UltiSnips.
let g:UltiSnipsSnippetsDir = stdpath('config') . '/UltiSnips'
let g:UltiSnipsEditSplit = 'context'

" Configure Lua plugins.
lua require('dietrichm.lsp')
lua require('dietrichm.completion')
lua require('dietrichm.treesitter')
lua require('dietrichm.telescope')
lua require('dietrichm.settings')

" Configure vim-test.
let g:test#echo_command = 0
let g:test#preserve_screen = 1
let g:test#python#runner = 'pytest'
let g:test#runner_commands = ['PyTest']
nnoremap <silent> <Leader>rc :update \| :TestFile<CR>
nnoremap <silent> <Leader>rt :update \| :TestNearest<CR>
nnoremap <silent> <Leader>rr :update \| :TestLast<CR>

" Configure vim-go.
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_fmt_fail_silently = 1
let g:go_imports_autosave = 0
let g:go_jump_to_error = 0

" Configure EditorConfig.
let g:EditorConfig_exclude_patterns = [
    \ 'fugitive://.*',
    \ '.git/COMMIT_EDITMSG'
\ ]

" Configure vim-markdown.
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_style_pythonic = 1
map <Plug> <Plug>Markdown_MoveToCurHeader

" Enable search highlight when searching for symbols.
nnoremap <silent> * :setlocal hlsearch \| :normal! *<CR>
nnoremap <silent> # :setlocal hlsearch \| :normal! #<CR>
nnoremap <silent> g* :setlocal hlsearch \| :normal! g*<CR>
nnoremap <silent> g# :setlocal hlsearch \| :normal! g#<CR>

" Toggle search highlight.
nnoremap <silent> \ :setlocal hlsearch!<CR>

" Up and down by visible lines.
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Paragraph motions do not change jumplist.
nnoremap <silent> } :keepjumps normal! }<CR>
nnoremap <silent> { :keepjumps normal! {<CR>

" Move through quickfix and location list.
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]L :llast<CR>
nnoremap <silent> [L :lfirst<CR>

" Use g] for :tjump.
nnoremap <silent> g] g<C-]>
nnoremap <silent> <C-W>g] <C-W>g<C-]>

" Delete all buffers.
nnoremap <silent> <Leader>da :%bd<CR>

" Path copy mappings.
nnoremap <silent> <Leader>pc :let @+ = @%<CR>
nnoremap <silent> <Leader>Pc :let @+ = @% . ":" . line(".")<CR>

" Use arrow keys for resizing splits.
nnoremap <silent> <Up>    :resize +1<CR>
nnoremap <silent> <Down>  :resize -1<CR>
nnoremap <silent> <Left>  :vertical resize +2<CR>
nnoremap <silent> <Right> :vertical resize -2<CR>
