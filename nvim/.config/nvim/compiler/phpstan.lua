vim.b.current_compiler = 'phpstan'

vim.cmd.CompilerSet([[makeprg=phpstan\ analyse\ -nv\ --no-progress\ --error-format=raw]])
vim.cmd.CompilerSet([[errorformat=%f:%l:%m,%-G%.%#]])
