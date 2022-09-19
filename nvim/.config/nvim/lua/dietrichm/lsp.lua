local lspconfig = require('lspconfig')

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
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<Leader>ca',
    [[<cmd>lua vim.lsp.buf.code_action()<CR>]], opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-S>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
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
  settings = {
    gopls = {
      staticcheck = true,
      buildFlags = { '-tags=tools,wireinject' },
    },
  },
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

local null_ls = require('null-ls')

null_ls.setup {
  on_attach = on_attach,
  sources = {
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.vint,
  }
}

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
