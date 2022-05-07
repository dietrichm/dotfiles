local lspconfig = require('lspconfig')
local use_null_ls = vim.env.NVIM_USE_NULL_LS == '1'

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>',
    [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>si',
    [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>sr',
    [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca',
    [[<cmd>lua vim.lsp.buf.code_action()<CR>]], opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-S>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  local has_force_ale_linting, force_ale_linting = pcall(vim.api.nvim_get_var, 'force_ale_linting')

  if has_force_ale_linting and force_ale_linting == 1 then
    vim.diagnostic.disable(bufnr)
    return
  end

  if not use_null_ls then
    vim.fn['ale#toggle#DisableBuffer'](bufnr)
  end

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lf', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local flags = {}

lspconfig.gopls.setup {
  cmd = { 'gopls', '-remote=auto' },
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
  root_dir = function()
    return vim.fn.getcwd()
  end,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        diagnosticMode = 'workspace',
      }
    }
  },
}

lspconfig.intelephense.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
}

lspconfig.fsautocomplete.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup {
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
        globals = { 'vim' },
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

if use_null_ls then
  local null_ls = require('null-ls')

  null_ls.setup {
    on_attach = on_attach,
  }
end

vim.fn.sign_define('DiagnosticSignError', {
  text = '❌',
})
vim.fn.sign_define('DiagnosticSignWarn', {
  text = '❗',
})
vim.fn.sign_define('DiagnosticSignInfo', {
  text = '💡',
})
vim.fn.sign_define('DiagnosticSignHint', {
  text = '💭',
})
