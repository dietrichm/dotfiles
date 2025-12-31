local loaded, copilot = pcall(require, 'copilot')
if not loaded then
  vim.api.nvim_create_user_command('LoadCopilot', function()
    vim.cmd.packadd('copilot.lua')
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
