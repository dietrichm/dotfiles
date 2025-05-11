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
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
  },
}
