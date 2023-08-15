local lspconfig = require('lspconfig')

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>',
    [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>si',
    [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>sr',
    [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>st',
    [[<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca',
    [[<cmd>lua vim.lsp.buf.code_action()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<Leader>ca',
    [[<cmd>lua vim.lsp.buf.code_action()<CR>]], opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-S>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

  vim.api.nvim_buf_create_user_command(
    bufnr,
    'LspSwitch',
    function(options)
      vim.cmd.LspStop()
      vim.api.nvim_clear_autocmds({ group = 'lspconfig' })
      vim.cmd.LspStart(options.fargs[1])
    end,
    {
      nargs = 1,
      complete = function()
        local items = require('lspconfig.util').available_servers()
        table.sort(items)
        return items
      end,
    }
  )
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
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
  settings = {
    intelephense = {
      files = {
        maxSize = 6000000,
      },
      format = {
        enable = false,
      },
    },
  },
}

lspconfig.phpactor.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
  autostart = false,
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
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
    null_ls.builtins.formatting.pint,
  }
}
