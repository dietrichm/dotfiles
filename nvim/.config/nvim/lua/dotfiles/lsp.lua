local cmp_nvim_lsp_loaded, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if vim.env.NVIM_COMPLETION ~= '1' and cmp_nvim_lsp_loaded then
  vim.lsp.config('*', {
    capabilities = cmp_nvim_lsp.default_capabilities(),
  })
end

vim.lsp.config('gopls', {
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
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
        library = { vim.env.VIMRUNTIME },
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
  'clangd',
  'gopls',
  'intelephense',
  'lua_ls',
  'marksman',
  'ts_ls',
}
