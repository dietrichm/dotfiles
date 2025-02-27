local loaded, gitsigns = pcall(require, 'gitsigns')
if not loaded then
  return
end

gitsigns.setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
    untracked = { text = '┆' },
  },
  attach_to_untracked = false,
  signs_staged_enable = false,
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
    end

    map('n', '<Leader>gb', gitsigns.blame)
    map('n', '<Leader>gd', gitsigns.diffthis)

    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    vim.api.nvim_buf_create_user_command(0, 'Greset', gitsigns.reset_buffer, {})
  end,
}
