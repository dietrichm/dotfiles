let current_compiler = 'markdown'

CompilerSet makeprg=markdown\ -f\ fencedcode\ -o\ %:p:r:S.html\ %:p:S
