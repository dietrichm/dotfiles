vim.b.current_compiler = 'markdown'

vim.cmd.CompilerSet([[makeprg=markdown\ -f\ fencedcode\ -o\ %<.html]])
