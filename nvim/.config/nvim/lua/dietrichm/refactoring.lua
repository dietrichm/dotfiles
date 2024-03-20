local loaded, refactoring = pcall(require, 'refactoring')
if not loaded then
  return
end

refactoring.setup()
