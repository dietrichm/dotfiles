local loaded, formatter = pcall(require, 'formatter')
if not loaded then
  return
end

formatter.setup {
  filetype = {
    php = {
      require('formatter.filetypes.php').pint,
    },
    javascript = {
      require('formatter.filetypes.javascript').prettier,
    },
    lua = {
      require('formatter.filetypes.lua').stylua,
    },
    python = {
      require('formatter.filetypes.python').isort,
      require('formatter.filetypes.python').black,
    },
  },
}
