local lspconfig = require('lspconfig')

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, silent = true }
  local telescope = require('telescope.builtin')

  vim.keymap.set('n', '<C-]>', telescope.lsp_definitions, opts)
  vim.keymap.set('n', '<Leader>si', telescope.lsp_implementations, opts)
  vim.keymap.set('n', '<Leader>sr', telescope.lsp_references, opts)
  vim.keymap.set('n', '<Leader>st', telescope.lsp_type_definitions, opts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('v', '<Leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('i', '<C-S>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, opts)

  -- Avoid jumping text when (diagnostic) signs are (un)set.
  vim.opt_local.signcolumn = 'auto:1-2'

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

local flags = {}

lspconfig.gopls.setup {
  cmd = { 'gopls', '-remote=auto' },
  on_attach = on_attach,
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
  flags = flags,
  autostart = false,
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  flags = flags,
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
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
