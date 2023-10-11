local lspconfig = require('lspconfig')

local on_attach = function(_, bufnr)
  local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end
  local telescope = require('telescope.builtin')

  map('n', '<Leader>si', telescope.lsp_implementations)
  map('n', '<Leader>sr', telescope.lsp_references)
  map('n', '<Leader>st', telescope.lsp_type_definitions)
  map('n', '<Leader>tb', telescope.lsp_document_symbols)
  map('n', '<Leader>ca', vim.lsp.buf.code_action)
  map('v', '<Leader>ca', vim.lsp.buf.code_action)
  map('n', 'K', vim.lsp.buf.hover)
  map('i', '<C-S>', vim.lsp.buf.signature_help)
  map('n', '<Leader>rn', vim.lsp.buf.rename)
  map('n', '<Leader>lf', vim.lsp.buf.format)
  map('n', '+', vim.lsp.buf.document_highlight)

  -- Avoid jumping text when (diagnostic) signs are (un)set.
  vim.opt_local.signcolumn = 'yes'

  vim.api.nvim_create_autocmd('CursorMoved', {
    group = 'vimrc',
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })

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
