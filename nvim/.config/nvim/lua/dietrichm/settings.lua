require('gitsigns').setup {
  attach_to_untracked = false,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })
  end
}

require('nvim-tree').setup {
  view = {
    width = 45,
  },
  git = {
    ignore = false,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}

require('nvim-tree.view').View.winopts.signcolumn = 'auto'

vim.g.splitjoin_php_method_chain_full = 1

vim.fn.sign_define('DiagnosticSignError', {
  text = '❌',
})
vim.fn.sign_define('DiagnosticSignWarn', {
  text = '❗',
})
vim.fn.sign_define('DiagnosticSignInfo', {
  text = '💡',
})
vim.fn.sign_define('DiagnosticSignHint', {
  text = '💭',
})
