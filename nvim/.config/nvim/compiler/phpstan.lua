vim.b.current_compiler = 'phpstan'

vim.cmd.CompilerSet([[makeprg=phpstan\ analyse\ --memory-limit=2G\ --no-progress\ --error-format=raw]])
vim.cmd.CompilerSet([[errorformat=%f:%l:%m,%-GNote:\ %.%#]])
