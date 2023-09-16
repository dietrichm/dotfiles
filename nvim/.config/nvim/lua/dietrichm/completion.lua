local cmp = require('cmp')

vim.opt.complete = { '.' }
vim.opt.completeopt = { 'menuone', 'noinsert' }
vim.opt.pumwidth = 20

cmp.setup {
  completion = {
    autocomplete = false,
    completeopt = vim.o.completeopt,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  })
}
