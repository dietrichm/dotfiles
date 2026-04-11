local loaded, codecompanion = pcall(require, 'codecompanion')
if not loaded then
  vim.api.nvim_create_user_command('LoadAI', function()
    vim.pack.add { 'https://github.com/olimorris/codecompanion.nvim' }
    package.loaded['dotfiles.ai'] = nil
    require('dotfiles.ai')
  end, {})
  return
end

codecompanion.setup {
  interactions = {
    chat = {
      adapter = 'mistral_vibe',
    },
  },
}
