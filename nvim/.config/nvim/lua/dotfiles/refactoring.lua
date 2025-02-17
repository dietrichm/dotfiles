local loaded, refactoring = pcall(require, 'refactoring')
if not loaded then
  return
end

refactoring.setup()

vim.keymap.set('n', 'grv', [[:Refactor inline_var<CR>]])
vim.keymap.set('x', 'grv', [[:Refactor extract_var ]])
