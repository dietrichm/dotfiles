if not pcall(require, 'nvim-treesitter') then
  return
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('dotfiles_treesitter', { clear = true }),
  callback = function()
    if vim.bo.buftype == '' and pcall(vim.treesitter.start) then
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

require('nvim-treesitter-textobjects').setup {
  select = {
    lookahead = true,
    include_surrounding_whitespace = false,
    selection_modes = {
      ['@function.outer'] = 'V',
      ['@function.inner'] = 'V',
      ['@parameter.outer'] = 'v',
      ['@parameter.inner'] = 'v',
    },
  },
  move = {
    set_jumps = true,
  },
}

local map = vim.keymap.set
local select = require('nvim-treesitter-textobjects.select')
local move = require('nvim-treesitter-textobjects.move')

map({ 'x', 'o' }, 'af', function()
  select.select_textobject('@function.outer', 'textobjects')
end)
map({ 'x', 'o' }, 'if', function()
  select.select_textobject('@function.inner', 'textobjects')
end)
map({ 'x', 'o' }, 'aa', function()
  select.select_textobject('@parameter.outer', 'textobjects')
end)
map({ 'x', 'o' }, 'ia', function()
  select.select_textobject('@parameter.inner', 'textobjects')
end)
map({ 'n', 'x', 'o' }, ']m', function()
  move.goto_next_start('@function.outer', 'textobjects')
end)
map({ 'n', 'x', 'o' }, ']M', function()
  move.goto_next_end('@function.outer', 'textobjects')
end)
map({ 'n', 'x', 'o' }, '[m', function()
  move.goto_previous_start('@function.outer', 'textobjects')
end)
map({ 'n', 'x', 'o' }, '[M', function()
  move.goto_previous_end('@function.outer', 'textobjects')
end)

local treesj = require('treesj')

treesj.setup {
  use_default_keymaps = false,
  max_join_length = 200,
}

map('n', 'grj', treesj.join)
map('n', 'grs', treesj.split)

require('treesitter-context').setup {
  max_lines = 5,
  multiline_threshold = 1,
  trim_scope = 'inner',
}

require('nvim-ts-autotag').setup {
  aliases = {
    gotmpl = 'html',
  },
  per_filetype = {
    php = {
      enable_close = false,
    },
  },
}
