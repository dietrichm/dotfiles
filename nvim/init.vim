scriptencoding utf-8

let s:nvim_config_root = $HOME . '/.config/nvim'
let s:load_line_plugins = 0

let s:vim_plug_script = s:nvim_config_root . '/autoload/plug.vim'
if empty(glob(s:vim_plug_script))
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

" UI and colours.
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    if s:load_line_plugins
        Plug 'dietrichm/promptline.vim'
        Plug 'edkolev/tmuxline.vim'
    endif

" Editing.
Plug 'editorconfig/editorconfig-vim'
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'marlonfan/coc-phpls', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-sources', {'as': 'coc-ultisnips', 'do': 'yarn install --frozen-lockfile', 'rtp': 'packages/ultisnips'}
    Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
    Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
Plug 'w0rp/ale'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-highlightedyank'

" Git.
Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'tommcdo/vim-fubitive'
Plug 'mhinz/vim-signify'

" Developing.
Plug 'vim-vdebug/vdebug'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" PHP.
Plug 'StanAngeloff/php.vim'
Plug 'alvan/vim-php-manual'
Plug 'tobyS/pdv'
    Plug 'tobyS/vmustache'
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug 'sniphpets/sniphpets'
    Plug 'sniphpets/sniphpets-common'
    Plug 'sniphpets/sniphpets-phpunit'

" JavaScript.
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Other syntax.
Plug 'lumiliet/vim-twig'

call plug#end()

" Map the leader key to SPACE
let mapleader = "\<SPACE>"

" General settings
set scrolloff=2
set number
set numberwidth=1
set pastetoggle=<F2>
set fileformats=unix
set noshowmode
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
set listchars=tab:→\ ,extends:»,precedes:«,trail:▒,nbsp:·
set list
set hidden
set updatetime=250
set shortmess+=cIW
set spelllang=en_gb
set path=.,**2
set grepprg=rg\ --vimgrep

" Persistent undo.
let &undodir = s:nvim_config_root . '/undodir'
set undofile

" Colours
set background=dark
colorscheme base16-bright

" Wrong spell words have black text.
highlight SpellBad ctermfg=0
highlight SpellLocal ctermfg=0
highlight SpellCap ctermfg=0
highlight SpellRare ctermfg=0

" Increase contrast in Golang coverage colours.
highlight goCoverageCovered ctermfg=lightcyan
highlight goCoverageUncover ctermfg=red

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

" Configure NERDCommenter.
let g:NERDDefaultAlign = 'left'

" Configure PHP syntax.
let g:php_html_load = 0
let g:php_var_selector_is_identifier = 1
let g:php_manual_online_search_shortcut = ''
let g:php_namespace_sort_after_insert = 1
let g:PHP_noArrowMatching = 1

" Configure Phpactor.
let g:phpactorPhpBin = '/usr/local/bin/php'

" Configure ALE.
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'
let g:ale_php_php_executable = '/usr/local/bin/php'

" Configure Airline.
let g:airline_powerline_fonts = 1
let g:airline_extensions = ['tabline', 'ale']
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#ale#error_symbol = '✘:'
let g:airline#extensions#ale#warning_symbol = '▲:'

" Configure Promptline.
if exists(':PromptlineSnapshot')
    let g:promptline_theme = 'airline_insert'
    let g:promptline_preset = {
        \ 'a': [ promptline#slices#host({ 'only_if_ssh': 1 }), promptline#slices#user() ],
        \ 'b': [ promptline#slices#cwd() ],
        \ 'c': [ '%#' ],
        \ 'x': [ promptline#slices#git_status() ],
        \ 'y': [ promptline#slices#vcs_branch() ],
        \ 'warn': [ promptline#slices#last_exit_code() ],
        \ 'options': {
            \ 'left_sections': [ 'a', 'b', 'c' ],
            \ 'right_sections': [ 'warn', 'x', 'y' ]
        \ }
    \ }
endif

" Configure tmuxline.
if exists(':TmuxlineSnapshot')
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
endif

augroup terminal
    autocmd!
    autocmd TermOpen * setlocal nonumber
augroup END

augroup fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
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
    \ 'php': 'coc',
    \ 'markdown': 'toc',
\ }
let g:vista_ignore_kinds = ['Function', 'Variable']
let g:vista_sidebar_width = 45
nnoremap <silent> <Leader>tb :Vista<CR>

" Configure FZF.
nnoremap <silent> <Leader>o :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>fh :History<CR>
let $FZF_DEFAULT_OPTS .= ' --reverse --margin 0,1'
function! FloatingFZF()
    let width = float2nr(&columns * 0.8)
    let height = float2nr(&lines * 0.6)
    let opts = {
        \ 'relative': 'editor',
        \ 'row': (&lines - height) / 2,
        \ 'col': (&columns - width) / 2,
        \ 'width': width,
        \ 'height': height
    \ }
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
endfunction
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
let g:fzf_preview_window = ''

" Configure UltiSnips.
let g:UltiSnipsSnippetsDir = s:nvim_config_root . '/UltiSnips'
let g:UltiSnipsEditSplit = 'context'

" Configure COC.
nmap <silent> <Leader>sr <Plug>(coc-references)
inoremap <silent> <expr> <C-Space> coc#refresh()
nnoremap <silent> <Leader>h :call CocAction('doHover')<CR>
nnoremap <silent> <Leader>ts :echo get(b:, 'coc_current_function', '')<CR>

function! ApplyCocDefinitionMappings() abort
    " Jump to definition.
    nmap <silent> <buffer> <C-]> <Plug>(coc-definition)

    " Jump to definition in split.
    nnoremap <silent> <buffer> <C-W>] :call CocAction('jumpDefinition', 'vsplit')<CR>
    nnoremap <silent> <buffer> <C-W><C-]> :call CocAction('jumpDefinition', 'vsplit')<CR>
endfunction

" Configure Vdebug.
let g:vdebug_options = {
    \ 'ide_key': 'vdebug',
    \ 'path_maps': {
        \ '/code': getcwd(),
        \ '/var/www': getcwd(),
    \ },
\ }

" Configure vim-go.
let g:go_def_mapping_enabled = 0

" Configure splitjoin.
let g:splitjoin_php_method_chain_full = 1

" Configure PDV.
let g:pdv_template_dir = s:nvim_config_root . '/pdv-templates'

" Configure Sniphpets.
let g:sniphpets_common_disable_shortcuts = 1

" Configure EditorConfig.
let g:EditorConfig_exclude_patterns = [
    \ 'fugitive://.*',
    \ '.git/COMMIT_EDITMSG'
\ ]

" Configure highlightedyank.
let g:highlightedyank_highlight_duration = 750

" Enable search highlight when searching for symbols.
nnoremap <silent> * :setlocal hlsearch \| :normal! *<CR>
nnoremap <silent> # :setlocal hlsearch \| :normal! #<CR>
nnoremap <silent> g* :setlocal hlsearch \| :normal! g*<CR>
nnoremap <silent> g# :setlocal hlsearch \| :normal! g#<CR>

" Enable search highlight manually.
nnoremap <silent> \ :setlocal hlsearch<CR>

" Disable search highlight and reload signs using CR.
nnoremap <silent> <CR> :setlocal nohlsearch \| :SignifyRefresh<CR>
augroup carriage_return
    autocmd!
    " Except for in the quickfix and command line window.
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
augroup END

" Paragraph motions do not change jumplist.
nnoremap <silent> } :keepjumps normal! }<CR>
nnoremap <silent> { :keepjumps normal! {<CR>

" Move through quickfix list.
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [Q :cfirst<CR>

" Searching using ripgrep.
nnoremap <silent> <Leader>sw :execute "Rg \\b" . expand("<cword>") . "\\b"<CR>
command! -bang -nargs=* Rgi call fzf#vim#grep(
    \ "rg --ignore-vcs --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
    \ 1,
    \ {},
    \ <bang>0
\ )

" Delete all buffers.
nnoremap <silent> <Leader>da :%bd<CR>

" Path copy mappings.
nnoremap <silent> <Leader>pc :let @+ = @%<CR>
nnoremap <silent> <Leader>Pc :let @+ = @% . ":" . line(".")<CR>
nnoremap <silent> <Leader>tc :let @+ = @% . " --filter " . get(b:, 'coc_current_function', '')<CR>

" Use arrow keys for resizing splits.
nnoremap <silent> <Up>    :resize +1<CR>
nnoremap <silent> <Down>  :resize -1<CR>
nnoremap <silent> <Left>  :vertical resize +2<CR>
nnoremap <silent> <Right> :vertical resize -2<CR>
