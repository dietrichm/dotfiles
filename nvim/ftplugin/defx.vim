setlocal nonumber

nnoremap <silent> <buffer> <expr> <CR> defx#is_directory() ?
    \ defx#do_action('open') :
    \ defx#do_action('multi', ['drop', 'quit'])
nnoremap <silent> <buffer> <expr> c defx#do_action('copy')
nnoremap <silent> <buffer> <expr> m defx#do_action('move')
nnoremap <silent> <buffer> <expr> p defx#do_action('paste')
nnoremap <silent> <buffer> <expr> x defx#do_action('multi', [['drop', 'split'], 'quit'])
nnoremap <silent> <buffer> <expr> v defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
nnoremap <silent> <buffer> <expr> T defx#do_action('multi', ['quit', ['drop', 'tabnew']])
nnoremap <silent> <buffer> <expr> td defx#do_action('new_directory')
nnoremap <silent> <buffer> <expr> tf defx#do_action('new_file')
nnoremap <silent> <buffer> <expr> d defx#do_action('remove')
nnoremap <silent> <buffer> <expr> r defx#do_action('rename')
nnoremap <silent> <buffer> <expr> . defx#do_action('toggle_ignored_files')
nnoremap <silent> <buffer> <expr> o defx#do_action('open_or_close_tree')
nnoremap <silent> <buffer> <expr> - defx#do_action('cd', ['..'])
nnoremap <silent> <buffer> <expr> ~ defx#do_action('cd', [getcwd()])
nnoremap <silent> <buffer> <expr> q defx#do_action('quit')
