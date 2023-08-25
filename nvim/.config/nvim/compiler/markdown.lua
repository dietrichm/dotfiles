vim.b.current_compiler = 'markdown'

vim.cmd.CompilerSet([[makeprg=markdown\ -f\ fencedcode\ -o\ %:p:r:S.html\ %:p:S]])
