local loaded, lspconfig = pcall(require, 'lspconfig')
if not loaded then
  return
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('dotfiles_lsp', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local function map(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
    end
    local telescope = require('telescope.builtin')

    map('n', 'gd', telescope.lsp_definitions)
    map('n', 'gD', vim.lsp.buf.declaration)
    map('n', '<Leader>si', telescope.lsp_implementations)
    map('n', '<Leader>sr', telescope.lsp_references)
    map('n', '<Leader>st', telescope.lsp_type_definitions)
    map('n', '<Leader>tb', telescope.lsp_document_symbols)
    map({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action)
    map({ 'n', 'i' }, '<C-S>', vim.lsp.buf.signature_help)
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
  end,
})

if vim.fn.has('nvim-0.11') == 0 then
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    silent = true,
  })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.gopls.setup {
  capabilities = capabilities,
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

lspconfig.basedpyright.setup {
  capabilities = capabilities,
}

lspconfig.intelephense.setup {
  capabilities = capabilities,
  settings = {
    intelephense = {
      files = {
        exclude = {
          '**/.git/**',
          '**/.svn/**',
          '**/.hg/**',
          '**/CVS/**',
          '**/.DS_Store/**',
          '**/node_modules/**',
          '**/bower_components/**',
          '**/vendor/**/{Tests,tests}/**',
          '**/.history/**',
          '**/vendor/**/vendor/**',
          '**/cache/**',
        },
      },
      references = {
        exclude = {},
      },
      completion = {
        suggestObjectOperatorStaticMethods = false,
      },
    },
  },
}

lspconfig.ts_ls.setup {
  capabilities = capabilities,
  root_dir = require('lspconfig.util').root_pattern(
    'tsconfig-base.json',
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git'
  ),
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