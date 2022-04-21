local lspconfig = require('lspconfig')
local load_telescope = vim.env.NVIM_TELESCOPE == '1'

local on_attach = function(_, bufnr)
  local opts = {noremap = true, silent = true}

  if load_telescope then
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>',
      [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca',
      [[<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>si',
      [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>sr',
      [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], opts)
  else
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>si', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>sr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  end

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-S>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  local has_force_ale_linting, force_ale_linting = pcall(vim.api.nvim_get_var, 'force_ale_linting')

  if has_force_ale_linting and force_ale_linting == 1 then
    vim.diagnostic.disable(bufnr)
    return
  end

  vim.fn['ale#toggle#DisableBuffer'](bufnr)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local flags = {}

lspconfig.gopls.setup{
  cmd = {"gopls", "-remote=auto"},
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
  root_dir = function()
    return vim.fn.getcwd()
  end,
}

lspconfig.pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
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
  capabilities = capabilities,
  flags = flags,
}

lspconfig.fsautocomplete.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
}

lspconfig.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

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

if not load_telescope then
  require('lspfuzzy').setup{}

  local vista_executive_for = vim.g.vista_executive_for
  vista_executive_for.fsharp = 'nvim_lsp'
  vista_executive_for.go = 'nvim_lsp'
  vista_executive_for.javascript = 'nvim_lsp'
  vista_executive_for.php = 'nvim_lsp'
  vista_executive_for.python = 'nvim_lsp'
  vista_executive_for.typescript = 'nvim_lsp'
  vim.g.vista_executive_for = vista_executive_for
end
