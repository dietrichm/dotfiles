local loaded, refactoring = pcall(require, 'refactoring')
if not loaded then
  return
end

refactoring.setup()

vim.keymap.set('x', '<Leader>rv', [[:Refactor extract_var ]])
