local loaded, mini_pairs = pcall(require, 'mini.pairs')
if not loaded then
  return
end
mini_pairs.setup()

local mini_extra = require('mini.extra')
mini_extra.setup()

local mini_pick = require('mini.pick')
mini_pick.setup {
  source = {
    show = mini_pick.default_show,
  },
}

local builtin = mini_pick.builtin
local map = vim.keymap.set

map('n', '<Leader>o', builtin.files)
map('n', '<Leader>O', function()
  builtin.cli(
    { command = { 'rg', '--files', '--no-follow', '--color=never', '--no-ignore-vcs' } },
    { source = { name = 'Files (rg --no-ignore-vcs)' } }
  )
end)
map('n', '<Leader>b', builtin.buffers)
map('n', '<Leader>fh', function()
  mini_extra.pickers.oldfiles { current_dir = true }
end)
map('n', '<Leader>tr', builtin.resume)
map('n', '<Leader>fs', function()
  local file_root = vim.fn.expand('%:t:r')
  local file_root_without_test = file_root:gsub('_test$', ''):gsub('Test$', '')
  vim.schedule(function()
    mini_pick.set_picker_query { file_root_without_test }
  end)
  builtin.files()
end)
