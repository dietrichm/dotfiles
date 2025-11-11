vim.opt.complete:remove('t')
vim.opt.completeopt = { 'menu', 'menuone', 'popup', 'noinsert', 'fuzzy' }
vim.opt.pumwidth = 20

if vim.fn.has('nvim-0.12') == 1 then
  vim.opt.pummaxwidth = 120
end

if vim.env.NVIM_COMPLETION == '1' then
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('dotfiles_completion', { clear = true }),
    callback = function(args)
      local client_id = args.data.client_id
      local bufnr = args.buf
      vim.lsp.completion.enable(true, client_id, bufnr, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get, { buffer = bufnr })
    end,
  })
  -- vim.opt.complete = { 'o' }
  -- vim.opt.autocomplete = true
  return
end

local loaded, cmp = pcall(require, 'cmp')
if not loaded then
  return
end

cmp.setup {
  completion = {
    completeopt = vim.o.completeopt,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ['<CR>'] = cmp.mapping.confirm(),
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
  },
  window = {
    completion = {
      border = 'none',
    },
    documentation = {
      winhighlight = '',
    },
  },
}

vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
