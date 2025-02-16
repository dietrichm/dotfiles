local loaded, mini_pairs = pcall(require, 'mini.pairs')
if not loaded then
  return
end

mini_pairs.setup()
