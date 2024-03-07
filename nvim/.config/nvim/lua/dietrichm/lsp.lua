local loaded, lspconfig = pcall(require, 'lspconfig')
if not loaded then
  return
end

local on_attach = function(_, bufnr)
  local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end
  local telescope = require('telescope.builtin')

  map('n', 'gd', telescope.lsp_definitions)
  map('n', '<Leader>si', telescope.lsp_implementations)
  map('n', '<Leader>sr', telescope.lsp_references)
  map('n', '<Leader>st', telescope.lsp_type_definitions)
  map('n', '<Leader>tb', telescope.lsp_document_symbols)
  map('n', '<Leader>ca', vim.lsp.buf.code_action)
  map('v', '<Leader>ca', vim.lsp.buf.code_action)
  if vim.fn.has('nvim-0.10') == 0 then
    map('n', 'K', vim.lsp.buf.hover)
  end
  map('i', '<C-S>', vim.lsp.buf.signature_help)
  map('n', '<Leader>rn', vim.lsp.buf.rename)
  map('n', '<Leader>lf', vim.lsp.buf.format)

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

  vim.api.nvim_buf_create_user_command(bufnr, 'LspSwitch', function(options)
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
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  silent = true,
})

local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)
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
      },
    },
  },
}

lspconfig.intelephense.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
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

lspconfig.marksman.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
}
