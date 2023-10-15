local loaded, formatter = pcall(require, 'formatter')
if not loaded then
  return
end

formatter.setup {
  filetype = {
    php = {
      function()
        return {
          exe = 'pint',
          ignore_exitcode = true,
        }
      end,
    },
    lua = {
      require('formatter.filetypes.lua').stylua,
    },
  },
}
