local lspconfig = require('lspconfig')

local on_attach = function(_, bufnr)
  local opts = {noremap = true, silent = true}

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-S>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>si', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>sr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  local has_force_ale_linting, force_ale_linting = pcall(vim.api.nvim_get_var, 'force_ale_linting')

  if has_force_ale_linting and force_ale_linting == 1 then
    vim.diagnostic.disable(bufnr)
  else
    vim.call('ale#toggle#DisableBuffer', bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end
end

lspconfig.gopls.setup{
  cmd = {"gopls", "-remote=auto"},
  on_attach = on_attach,
  root_dir = function()
    return vim.fn.getcwd()
  end,
}

lspconfig.pyright.setup{
  on_attach = on_attach,
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        diagnosticMode = "workspace",
      }
    }
  },
}

lspconfig.intelephense.setup{
  on_attach = on_attach,
}

lspconfig.fsautocomplete.setup{
  on_attach = on_attach,
}

lspconfig.tsserver.setup{
  on_attach = on_attach,
}

local vista_executive_for = vim.g.vista_executive_for
vista_executive_for.fsharp = 'nvim_lsp'
vista_executive_for.go = 'nvim_lsp'
vista_executive_for.javascript = 'nvim_lsp'
vista_executive_for.php = 'nvim_lsp'
vista_executive_for.python = 'nvim_lsp'
vista_executive_for.typescript = 'nvim_lsp'
vim.g.vista_executive_for = vista_executive_for

vim.fn.sign_define('DiagnosticSignError', {
  text='❌',
})
vim.fn.sign_define('DiagnosticSignWarn', {
  text='❗',
})
vim.fn.sign_define('DiagnosticSignInfo', {
  text='💡',
})
vim.fn.sign_define('DiagnosticSignHint', {
  text='💭',
})

require('lspfuzzy').setup{}
