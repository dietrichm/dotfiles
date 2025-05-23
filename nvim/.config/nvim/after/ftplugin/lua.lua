vim.keymap.set('ia', 'dump', [[print(vim.inspect())<Left><Left>]], { buffer = true })

-- Surround text with `]` places double brackets.
vim.b.surround_93 = '[[\r]]'
