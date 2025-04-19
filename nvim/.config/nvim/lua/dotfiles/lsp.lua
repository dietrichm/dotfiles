vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('dotfiles_lsp', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local function map(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
    end
    local telescope = require('telescope.builtin')

    map('n', 'gd', vim.lsp.buf.declaration)
    map('n', 'gri', telescope.lsp_implementations)
    map('n', 'grr', telescope.lsp_references)
    map('n', 'gD', telescope.lsp_type_definitions)
    map('n', 'gO', telescope.lsp_document_symbols)

    map({ 'i', 'n' }, '<C-S>', function()
      vim.lsp.buf.signature_help { border = 'single' }
    end)

    map('n', 'K', function()
      vim.lsp.buf.hover { border = 'single' }
    end)

    map('n', '+', function()
      vim.lsp.buf.document_highlight()
      vim.api.nvim_create_autocmd('CursorMoved', {
        buffer = bufnr,
        once = true,
        callback = vim.lsp.buf.clear_references,
      })
    end)

    map('n', '<Leader>ih', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end)

    map('n', '<Leader>u', function()
      vim.lsp.buf.code_action {
        context = {
          only = { 'source.organizeImports' },
        },
        apply = true,
      }
    end)
  end,
})

if vim.env.NVIM_COMPLETION ~= '1' then
  vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })
end

vim.lsp.config('gopls', {
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
})

vim.lsp.config('intelephense', {
  settings = {
    intelephense = {
      files = {
        exclude = {
          '**/.git/**',
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
})

vim.lsp.config('lua_ls', {
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
        arrayIndex = 'Disable',
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
})

vim.lsp.enable {
  'basedpyright',
  'gopls',
  'intelephense',
  'lua_ls',
  'marksman',
  'ts_ls',
}
