vim.opt.complete:remove('t')
vim.opt.completeopt = { 'menu', 'menuone', 'popup', 'noinsert', 'fuzzy' }
vim.opt.pumwidth = 20
vim.opt.pummaxwidth = 100

if vim.env.NVIM_COMPLETION ~= '0' then
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('dotfiles_completion', { clear = true }),
    callback = function(args)
      vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
        autotrigger = true,
        convert = function(item)
          return {
            abbr = item.label:gsub('%b()', ''),
            menu = '',
          }
        end,
      })
      vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get, { buf = args.buf })
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
  formatting = {
    format = function(_, item)
      item.menu = ''
      return item
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-Space>'] = cmp.mapping.complete(),
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
