local loaded, zen_mode = pcall(require, 'zen-mode')
if not loaded then
  return
end

zen_mode.setup {
  window = {
    backdrop = 0,
    width = 100,
    height = 0.85,
    options = {
      signcolumn = 'no',
      number = false,
    },
  },
}
