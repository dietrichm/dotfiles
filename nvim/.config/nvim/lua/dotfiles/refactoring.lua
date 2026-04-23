local loaded, refactoring = pcall(require, 'refactoring')
if not loaded then
  return
end

vim.keymap.set('n', 'grv', [[:Refactor inline_var<CR>]])
vim.keymap.set('x', 'grv', [[:Refactor extract_var ]])
vim.keymap.set({ 'n', 'x' }, 'gre', refactoring.select_refactor)
