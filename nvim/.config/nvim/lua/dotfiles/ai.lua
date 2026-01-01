local copilot_loaded, copilot = pcall(require, 'copilot')
if not copilot_loaded then
  vim.api.nvim_create_user_command('LoadAI', function()
    vim.cmd.packadd('copilot.lua')
    vim.cmd.packadd('avante.nvim')
    vim.cmd.packadd('codecompanion.nvim')
    package.loaded['dotfiles.ai'] = nil
    require('dotfiles.ai')
  end, {})
  return
end

copilot.setup {
  filetypes = {
    ['*'] = false,
  },
}

local cmp_loaded, cmp = pcall(require, 'cmp')
if cmp_loaded then
  cmp.event:on('menu_opened', function()
    vim.b.copilot_suggestion_hidden = true
  end)
  cmp.event:on('menu_closed', function()
    vim.b.copilot_suggestion_hidden = false
  end)
end

local avante_loaded, avante = pcall(require, 'avante')
if avante_loaded then
  avante.setup {
    provider = 'copilot',
  }
end

local codecompanion_loaded, codecompanion = pcall(require, 'codecompanion')
if codecompanion_loaded then
  codecompanion.setup {}
end
