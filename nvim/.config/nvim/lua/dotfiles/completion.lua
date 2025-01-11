local loaded, cmp = pcall(require, 'cmp')
if not loaded then
  return
end

vim.opt.complete = { '.' }
vim.opt.completeopt = { 'menu', 'menuone', 'popup', 'noinsert' }
vim.opt.pumwidth = 20

if vim.fn.has('nvim-0.11') == 1 then
  vim.opt.completeopt:append('fuzzy')
end

cmp.setup {
  completion = {
    completeopt = vim.o.completeopt,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }),
}
