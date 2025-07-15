vim.b.current_compiler = 'phpstan'

vim.cmd.CompilerSet([[makeprg=phpstan\ analyse\ -n\ -v\ --no-progress\ --error-format=raw]])
vim.cmd.CompilerSet([[errorformat=%f:%l:%m,%-G%.%#]])
