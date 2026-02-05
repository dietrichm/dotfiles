local map = vim.keymap.set

map('i', '<C-;>', [[<C-O>:call searchpair('(', '', ')')<CR><Right>]], { silent = true })
map('i', '<C-u>', '<Nop>')
map('i', '<S-Tab>', '<Right>')
map('n', '#', [[:setlocal hlsearch | normal! #<CR>]])
map('n', '*', [[:setlocal hlsearch | normal! *<CR>]])
map('n', '<C-S>', vim.lsp.buf.signature_help)
map('n', '<Leader>da', [[:%bd<CR>]])
map('n', '<Leader>m', [[:silent lmake %<CR>]], { silent = true })
map('n', '<Leader>pc', [[:let @+ = expand('%:.') | echomsg "Copied:" @+<CR>]], { silent = true })
map('n', '<Leader>Pc', [[:let @+ = expand('%:p:~') | echomsg "Copied:" @+<CR>]], { silent = true })
map('n', '<Leader>q', [[:cclose | lclose<CR>]], { silent = true })
map('n', '<Leader>rc', [[:noautocmd update | TestFile<CR>]], { silent = true })
map('n', '<Leader>rr', [[:noautocmd update | TestLast<CR>]], { silent = true })
map('n', '<Leader>rt', [[:noautocmd update | TestNearest<CR>]], { silent = true })
map('n', '<Leader>sw', [[:silent execute 'grep! -Fw -- ' . shellescape(expand('<cword>'))<CR>]], { silent = true })
map('n', '<Leader>sW', [[:silent execute 'grep! -Fw -- ' . shellescape(expand('<cWORD>'))<CR>]], { silent = true })
map('n', '<Leader>w', [[:setlocal wrap!<CR>]])
map('n', '<Space>', '')
map('n', '\\', [[:call sneak#cancel() | setlocal hlsearch!<CR>]], { silent = true })
map('n', 'g#', [[:setlocal hlsearch | normal! g#<CR>]])
map('n', 'g*', [[:setlocal hlsearch | normal! g*<CR>]])
map('n', 'grd', vim.diagnostic.setloclist)
map('n', 'j', [[v:count == 0 && &bt != 'quickfix' ? 'gj' : 'j']], { expr = true })
map('n', 'k', [[v:count == 0 && &bt != 'quickfix' ? 'gk' : 'k']], { expr = true })
map('n', '{', [[:keepjumps normal! {<CR>]], { silent = true })
map('n', '}', [[:keepjumps normal! }<CR>]], { silent = true })
map('v', '<', [[<gv]])
map('v', '<Leader>s', [["gy :silent execute 'grep! -F -- ' . shellescape(@g)<CR>]], { silent = true })
map('v', '>', [[>gv]])

map('n', 'gd', function()
  local clients = vim.lsp.get_clients { bufnr = 0, method = 'textDocument/declaration' }
  if #clients > 0 then
    vim.lsp.buf.declaration()
    return
  end
  vim.cmd.normal { 'gd', bang = true }
end)

map('n', 'q', function()
  if vim.bo.buftype == 'terminal' then
    return ':bd<CR>'
  end
  if vim.bo.buftype == 'quickfix' then
    return '<C-W>c<C-W>p'
  end
  if vim.bo.filetype == 'gitsigns-blame' then
    return '<C-W>c'
  end
  return 'q'
end, { expr = true, silent = true })

map('n', '<Leader>gi', function()
  vim.bo.grepprg = vim.bo.grepprg == '' and vim.o.grepprg .. ' --no-ignore-vcs' or ''
  vim.cmd.set('grepprg?')
end)

map('n', '+', function()
  vim.lsp.buf.document_highlight()
  vim.api.nvim_create_autocmd('CursorMoved', {
    once = true,
    callback = vim.lsp.buf.clear_references,
  })
end)

map('n', '<Leader>ih', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

map('n', '<Leader>u', function()
  vim.lsp.buf.code_action {
    ---@diagnostic disable-next-line: missing-fields
    context = {
      only = { 'source.organizeImports' },
    },
    apply = true,
  }
end)

map('ia', 'rstr', function()
  return io.open('/dev/urandom'):read(500):gsub('[^%w]', ''):sub(0, 32)
end, { expr = true })

map('ia', 'rpwd', function()
  return io.open('/dev/urandom'):read(500):gsub('[^%w%p]', ''):sub(0, 32)
end, { expr = true })

map('ia', 'ruuid', function()
  return io.open('/proc/sys/kernel/random/uuid'):read()
end, { expr = true })

map('ia', 'ctime', function()
  return tostring(os.date('%FT%T%z')):gsub('+(%d%d)(%d%d)$', '+%1:%2')
end, { expr = true })
