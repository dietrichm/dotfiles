-- luacheck: globals TreesitterWinbar

local loaded, treesitter = pcall(require, 'nvim-treesitter')
if not loaded then
  return
end

function TreesitterWinbar()
  local line = treesitter.statusline {
    type_patterns = {
      'function_declaration',
      'method_declaration',
    },
    indicator_size = 9999,
  }

  if line == nil then
    return ''
  end

  return line
end

treesitter.define_modules {
  vimrc_winbar = {
    enable = true,
    attach = function()
      vim.wo.winbar = [[ %{v:lua.TreesitterWinbar()} ]]
    end,
    detach = function()
      vim.wo.winbar = nil
    end,
    is_supported = function(language)
      local languages = {
        'go',
        'php',
      }

      return vim.tbl_contains(languages, language)
    end,
  },
}
