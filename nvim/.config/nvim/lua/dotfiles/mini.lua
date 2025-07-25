local loaded, mini_pairs = pcall(require, 'mini.pairs')
if not loaded then
  return
end

mini_pairs.setup()

local mini_pick = require('mini.pick')
mini_pick.setup()

vim.keymap.set('n', '<Leader>fs', function()
  local file_root = vim.fn.expand('%:t:r')
  local file_root_without_test = file_root:gsub('_test$', ''):gsub('Test$', '')
  vim.schedule(function()
    mini_pick.set_picker_query { file_root_without_test }
  end)
  mini_pick.builtin.files()
end)
