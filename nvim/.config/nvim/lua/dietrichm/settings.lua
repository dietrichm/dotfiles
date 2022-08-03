require('gitsigns').setup {
  signs = {
    add          = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change       = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
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
  renderer = {
    icons = {
      symlink_arrow = ' -> ',
      show = {
        file = false,
        folder = true,
        folder_arrow = false,
        git = false,
      },
      glyphs = {
        default = '',
        symlink = '',
        folder = {
          arrow_closed = '',
          arrow_open = '',
          default = '+',
          open = '-',
          empty = '+',
          empty_open = '-',
          symlink = '+',
          symlink_open = '-',
        },
      },
    },
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

require('nvim-tree.view').View.winopts.cursorline = true