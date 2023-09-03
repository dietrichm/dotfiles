require('formatter').setup {
  filetype = {
    php = {
      function()
        return {
          exe = 'pint',
        }
      end
    }
  }
}
