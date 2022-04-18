scriptencoding utf-8

let s:load_telescope = $NVIM_TELESCOPE == 1
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
if s:load_telescope
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
else
    Plug 'junegunn/fzf', {'do': './install --all'}
    Plug 'junegunn/fzf.vim'
    Plug 'ojroques/nvim-lspfuzzy'
    Plug 'liuchengxu/vista.vim'
endif
Plug 'Shougo/defx.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'embear/vim-localvimrc'
Plug 'preservim/vimux'
Plug 'nvim-lua/plenary.nvim'

" UI and colours.
Plug 'chriskempson/base16-vim'
Plug 'NLKNguyen/papercolor-theme'
if s:load_line_plugins
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'edkolev/promptline.vim'
    Plug 'edkolev/tmuxline.vim'
endif

" Editing.
Plug 'editorconfig/editorconfig-vim'
Plug 'SirVer/ultisnips'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'dense-analysis/ale'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

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
Plug 'maxmellon/vim-jsx-pretty'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'adelarsq/neofsharp.vim'

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

" Configure netrw.
let g:netrw_banner = 0
let g:netrw_bufsettings = 'noma nomod nonu nowrap ro nobl nolist'

" Configure defx.
call defx#custom#column('indent', 'indent', '  ')
call defx#custom#column('time', 'format', '%a %d/%m/%Y %H:%M')
nnoremap <silent> <Leader>ft :Defx
    \ -search-recursive=`expand('%:p')`
    \ -show-ignored-files
    \ -split=vertical
    \ -winwidth=45
    \ -direction=topleft<CR>
nnoremap <silent> <Leader>ff :Defx `expand('%:p:h')`
    \ -search=`expand('%:p')`
    \ -show-ignored-files
    \ -split=vertical
    \ -winwidth=45
    \ -direction=topleft<CR>
command DefxScratch :Defx -columns=mark:indent:icon:filename:time -sort=Time

" Configure Localvimrc.
let g:localvimrc_persistent = 1

" Configure PHP syntax.
let g:PHP_noArrowMatching = 1

" Configure ALE.
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '❗'
let g:ale_disable_lsp = 1
augroup ale
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
nnoremap <silent> [d :ALEPrevious<CR>
nnoremap <silent> ]d :ALENext<CR>
nnoremap <silent> <Leader>lf :ALEFix<CR>

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

" Configure tmuxline.
let g:tmuxline_theme = 'airline'
let g:tmuxline_preset = {
    \ 'a': '#S',
    \ 'win': '#I#F #W',
    \ 'cwin': '#I#F #W',
    \ 'y': '#{battery_percentage}',
    \ 'z': '%R',
    \ 'options': {
        \ 'status-justify': 'left'
    \ }
\ }

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

if s:load_telescope
    nnoremap <silent> <Leader>tb <cmd>lua require('telescope.builtin').lsp_document_symbols({ignore_symbols={'variable'}})<CR>
else
    nnoremap <silent> <Leader>tb :Vista<CR>
endif

" Configure FZF.
let $FZF_DEFAULT_OPTS .= ' --reverse'
let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8}}
let g:fzf_preview_window = ['right:50%:hidden:+{2}-/2', 'ctrl-/']

if s:load_telescope
    " Bind Telescope mappings.
    nnoremap <silent> <Leader>o <cmd>lua require('telescope.builtin').find_files({hidden=true, no_ignore=true})<CR>
    nnoremap <silent> <Leader>b <cmd>lua require('telescope.builtin').buffers()<CR>
    " TODO: <Leader>w
    nnoremap <silent> <Leader>fh <cmd>lua require('telescope.builtin').oldfiles()<CR>
    nnoremap <silent> <Leader>sw <cmd>lua require('telescope.builtin').grep_string({word_match='-w'})<CR>
else
    " Bind FZF mappings.
    nnoremap <silent> <Leader>o :Files<CR>
    nnoremap <silent> <Leader>b :Buffers<CR>
    nnoremap <silent> <Leader>w :Windows<CR>
    nnoremap <silent> <Leader>fh :History<CR>
    nnoremap <silent> <Leader>sw :execute "Rg \\b" . expand("<cword>") . "\\b"<CR>
endif

" Configure UltiSnips.
let g:UltiSnipsSnippetsDir = stdpath('config') . '/UltiSnips'
let g:UltiSnipsEditSplit = 'context'

" Configure Lua plugins.
lua require('lsp')
lua require('completion')
lua require('treesitter')
lua require('settings')
if s:load_telescope
    lua require('fuzzy')
endif

" Configure vim-test.
let g:test#preserve_screen = 1
let g:test#python#runner = 'pytest'
let g:test#runner_commands = ['PyTest']
let g:test#strategy = 'vimux'
nnoremap <silent> <Leader>rc :update \| :TestFile<CR>
nnoremap <silent> <Leader>rt :update \| :TestNearest<CR>
nnoremap <silent> <Leader>rr :update \| :TestLast<CR>

" Configure vim-go.
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0
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

" Searching using ripgrep.
if s:load_telescope
    command! -nargs=* Rg lua require('telescope.builtin').grep_string({search=<q-args>, use_regex=true})
    command! -nargs=* Rgi lua require('telescope.builtin').grep_string({search=<q-args>, use_regex=true, additional_args=function(opts)
        \ table.insert(opts, '--ignore-vcs')
        \ return opts
    \ end})
else
    command! -bang -nargs=* Rgi call fzf#vim#grep(
        \ 'rg --ignore-vcs --column --line-number --no-heading --color=always --smart-case -- ' . shellescape(<q-args>),
        \ 1,
        \ call('fzf#vim#with_preview', g:fzf_preview_window),
        \ <bang>0
    \ )
endif

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
