local loaded, cmp = pcall(require, 'cmp')
if not loaded then
  return
end

vim.opt.complete = { '.' }
vim.opt.completeopt = { 'menu', 'menuone', 'popup' }
vim.opt.pumwidth = 20

cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<M-p>'] = function()
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.open_docs()
      end
    end,
  }),
  view = {
    docs = {
      auto_open = false,
    },
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }),
}
