vim.keymap.set('ia', 'dump', [[print(vim.inspect())<Left><Left>]], { buf = 0 })

-- Surround text with `]` places double brackets.
vim.b.surround_93 = '[[\r]]'
