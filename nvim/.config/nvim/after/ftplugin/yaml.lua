-- OpenAPI relative reference.
vim.keymap.set('ia', 'schema', [[$ref: '#/components/schemas/'<Left>]], { buffer = true })
vim.keymap.set('ia', 'param', [[$ref: '#/components/parameters/'<Left>]], { buffer = true })
