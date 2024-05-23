local loaded, lspconfig = pcall(require, 'lspconfig')
if not loaded then
  return
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = 'vimrc',
  callback = function(args)
    local bufnr = args.buf
    local function map(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
    end
    local telescope = require('telescope.builtin')

    map('n', 'gd', telescope.lsp_definitions)
    map('n', 'gD', vim.lsp.buf.declaration)
    map('n', '<Leader>si', telescope.lsp_implementations)
    map('n', '<Leader>sr', telescope.lsp_references)
    map('n', '<Leader>st', telescope.lsp_type_definitions)
    map('n', '<Leader>tb', telescope.lsp_document_symbols)
    map('n', '<Leader>ca', vim.lsp.buf.code_action)
    map('v', '<Leader>ca', vim.lsp.buf.code_action)
    map('i', '<C-S>', vim.lsp.buf.signature_help)
    map('n', '<Leader>rn', vim.lsp.buf.rename)
    map('n', '<Leader>lf', vim.lsp.buf.format)

    map('n', 'K', function()
      vim.fn['sneak#cancel']()
      vim.lsp.buf.hover()
    end)

    map('n', '+', function()
      vim.lsp.buf.document_highlight()
      vim.api.nvim_create_autocmd('CursorMoved', {
        buffer = bufnr,
        once = true,
        callback = vim.lsp.buf.clear_references,
      })
    end)

    -- Avoid jumping text when (diagnostic) signs are (un)set.
    vim.opt_local.signcolumn = 'yes'
  end,
})

vim.api.nvim_create_user_command('LspSwitch', function(options)
  vim.cmd.LspStop()
  vim.api.nvim_clear_autocmds({ group = 'lspconfig' })
  vim.cmd.LspStart(options.fargs[1])
end, {
  nargs = 1,
  complete = function()
    local items = require('lspconfig.util').available_servers()
    table.sort(items)
    return items
  end,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  silent = true,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.gopls.setup {
  cmd = { 'gopls', '-remote=auto' },
  capabilities = capabilities,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  settings = {
    gopls = {
      staticcheck = true,
      buildFlags = { '-tags=tools,wireinject' },
      hints = {
        compositeLiteralFields = true,
        parameterNames = true,
      },
    },
  },
}

lspconfig.pyright.setup {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        diagnosticMode = 'workspace',
      },
    },
  },
}

lspconfig.intelephense.setup {
  capabilities = capabilities,
  settings = {
    intelephense = {
      references = {
        exclude = {},
      },
    },
  },
}

lspconfig.phpactor.setup {
  capabilities = capabilities,
  autostart = false,
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      hint = {
        enable = true,
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

lspconfig.marksman.setup {
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup {
  capabilities = capabilities,
}
