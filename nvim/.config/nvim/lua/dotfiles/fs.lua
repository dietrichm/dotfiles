local loaded, oil = pcall(require, 'oil')
if not loaded then
  return
end

oil.setup {
  columns = {},
  view_options = {
    show_hidden = true,
  },
  win_options = {
    cursorlineopt = 'both',
  },
  git = {
    mv = function()
      return true
    end,
  },
  keymaps = {
    ['<C-h>'] = false,
    ['<C-l>'] = false,
    ['<C-p>'] = false,
    ['<C-r>'] = 'actions.refresh',
    ['<C-s>'] = { 'actions.select', opts = { horizontal = true, close = true } },
    ['<C-t>'] = { 'actions.select', opts = { tab = true, close = true } },
    ['<C-v>'] = { 'actions.select', opts = { vertical = true, close = true } },
    ['<Tab>'] = 'actions.preview',
    ['q'] = 'actions.close',
  },
}

local set_sort = oil.set_sort
oil.set_sort = function(sort)
  set_sort(sort)
  local columns = {}
  for _, sort_pair in ipairs(sort) do
    local name = sort_pair[1]
    if name ~= 'type' and name ~= 'name' then
      table.insert(columns, name)
    end
  end
  oil.set_columns(columns)
end

vim.keymap.set('n', '-', oil.open)
