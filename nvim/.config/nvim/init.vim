scriptencoding utf-8

let s:nvim_config_root = $HOME . '/.config/nvim'
let s:load_line_plugins = 0
let s:load_coc_plugins = executable('yarn') == 1
let s:load_go_plugins = executable('go') == 1
let s:load_php_plugins = executable('php') == 1

let s:vim_plug_script = s:nvim_config_root . '/autoload/plug.vim'
if empty(glob(s:vim_plug_script))
    if !s:load_coc_plugins && confirm('Yarn is not installed - install plugins without COC?', "Yes\nNo") != 1
        finish
    endif

    execute '!curl -fLo ' . shellescape(s:vim_plug_script) . ' --create-dirs '
        \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    " vint: next-line -ProhibitAutocmdWithNoGroup
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Tools.
Plug 'junegunn/fzf', {'do': './install --all'}
    Plug 'junegunn/fzf.vim'
Plug 'Shougo/defx.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'embear/vim-localvimrc'
Plug 'preservim/vimux'

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
if s:load_coc_plugins
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    if s:load_php_plugins
        Plug 'marlonfan/coc-phpls', {'do': 'yarn install --frozen-lockfile'}
    endif
    Plug 'neoclide/coc-sources', {'as': 'coc-ultisnips', 'do': 'yarn install --frozen-lockfile', 'rtp': 'packages/ultisnips'}
    Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
    Plug 'fannheyward/coc-pyright', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
    if s:load_go_plugins
        Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
    endif
endif
Plug 'dense-analysis/ale'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Git.
Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'mhinz/vim-signify'

" Developing.
Plug 'vim-test/vim-test'
Plug 'vim-vdebug/vdebug'
if s:load_go_plugins
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
endif

" PHP.
if s:load_php_plugins
    Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}
endif

" JavaScript.
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Python.
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'Vimjas/vim-python-pep8-indent'

" Other syntax.
Plug 'cespare/vim-toml'
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
set inccommand=nosplit
set nowrapscan
set linebreak
set title
set titlestring=%F
set listchars=tab:→\ ,extends:»,precedes:«,trail:▒,nbsp:·
set list
set hidden
set updatetime=100
set shortmess+=cIW
set spelllang=en_gb
set path=.,*
set grepprg=rg\ --vimgrep
set undofile
if s:load_coc_plugins
    set tagfunc=CocTagFunc
endif
set signcolumn=yes

" Comments are rendered in italic.
highlight Comment cterm=italic

" Configure netrw.
let g:netrw_banner = 0
let g:netrw_bufsettings = 'noma nomod nonu nowrap ro nobl nolist'

" Configure defx.
nnoremap <silent> <Leader>ft :Defx `expand('%:p:h')`
    \ -search=`expand('%:p')`
    \ -show-ignored-files
    \ -split=vertical
    \ -winwidth=45
    \ -direction=topleft<CR>

" Configure Localvimrc.
let g:localvimrc_persistent = 1

" Configure PHP syntax.
let g:PHP_noArrowMatching = 1

" Configure Semshi.
let g:semshi#error_sign = v:false
let g:semshi#mark_selected_nodes = 0

" Configure ALE.
let g:ale_lint_on_enter = 0
let g:ale_list_window_size = 3
let g:ale_open_list = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'
augroup ale
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
nnoremap <silent> <Leader>lf :ALEFix<CR>

" Configure Airline.
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
    autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=750}
augroup END

" Configure vim-signify.
let g:signify_sign_change = '~'
let g:signify_sign_show_count = 0
let g:signify_update_on_focusgained = 1
let g:signify_vcs_list = ['git']
augroup signify
    autocmd!
    autocmd BufEnter * SignifyRefresh
augroup END

" Configure vista.
let g:vista#renderer#enable_icon = 0
let g:vista_close_on_jump = 1
let g:vista_echo_cursor = 0
let g:vista_executive_for = {
    \ 'go': 'coc',
    \ 'markdown': 'toc',
    \ 'php': 'coc',
\ }
let g:vista_ignore_kinds = ['Variable', 'Unknown']
let g:vista_sidebar_width = 45
nnoremap <silent> <Leader>tb :Vista<CR>

" Configure FZF.
nnoremap <silent> <Leader>o :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>fh :History<CR>
let $FZF_DEFAULT_OPTS .= ' --reverse'
let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8}}
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']

" Configure UltiSnips.
let g:UltiSnipsSnippetsDir = s:nvim_config_root . '/UltiSnips'
let g:UltiSnipsEditSplit = 'context'

" Configure COC.
nmap <silent> <Leader>ca <Plug>(coc-codeaction)
nmap <silent> <Leader>re <Plug>(coc-refactor)
nmap <silent> <Leader>rn <Plug>(coc-rename)
nmap <silent> <Leader>si <Plug>(coc-implementation)
nmap <silent> <Leader>sr <Plug>(coc-references)
xmap <silent> <Leader>ca <Plug>(coc-codeaction-selected)
inoremap <silent> <expr> <C-Space> coc#refresh()
nnoremap <silent> <Leader>h :call CocActionAsync('doHover')<CR>

" Configure vim-test.
let g:test#preserve_screen = 1
let g:test#python#runner = 'pytest'
let g:test#runner_commands = ['PyTest']
let g:test#strategy = 'vimux'
nnoremap <silent> <Leader>rc :TestFile<CR>
nnoremap <silent> <Leader>rt :TestNearest<CR>
nnoremap <silent> <Leader>rr :TestLast<CR>

" Configure Vdebug.
let g:vdebug_options = {
    \ 'ide_key': 'vdebug',
    \ 'path_maps': {
        \ '/code': getcwd(),
        \ '/var/www': getcwd(),
    \ },
\ }

" Configure vim-go.
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_fmt_fail_silently = 1
let g:go_jump_to_error = 0

" Configure splitjoin.
let g:splitjoin_php_method_chain_full = 1

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

" Searching using ripgrep.
nnoremap <silent> <Leader>sw :execute "Rg \\b" . expand("<cword>") . "\\b"<CR>
command! -bang -nargs=* Rgi call fzf#vim#grep(
    \ 'rg --ignore-vcs --column --line-number --no-heading --color=always --smart-case -- ' . shellescape(<q-args>),
    \ 1,
    \ call('fzf#vim#with_preview', g:fzf_preview_window),
    \ <bang>0
\ )

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
