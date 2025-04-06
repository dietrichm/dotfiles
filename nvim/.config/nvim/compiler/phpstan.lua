vim.b.current_compiler = 'phpstan'

vim.cmd.CompilerSet([[makeprg=phpstan\ analyse\ -v\ --memory-limit=2G\ --no-progress\ --error-format=raw]])
vim.cmd.CompilerSet([[errorformat=%f:%l:%m,%-G%.%#]])
