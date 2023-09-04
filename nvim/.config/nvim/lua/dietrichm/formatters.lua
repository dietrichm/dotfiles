require('formatter').setup {
  filetype = {
    php = {
      function()
        return {
          exe = 'pint',
          ignore_exitcode = true,
        }
      end
    }
  }
}
