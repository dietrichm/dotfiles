-- OpenAPI relative reference.
vim.keymap.set('ia', 'schema', [[$ref: '#/components/schemas/'<Left>]], { buf = 0 })
vim.keymap.set('ia', 'param', [[$ref: '#/components/parameters/'<Left>]], { buf = 0 })
