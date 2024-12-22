local loaded, refactoring = pcall(require, 'refactoring')
if not loaded then
  return
end

refactoring.setup()

vim.keymap.set('n', '<Leader>rv', [[:Refactor inline_var<CR>]])
vim.keymap.set('x', '<Leader>rv', [[:Refactor extract_var ]])
