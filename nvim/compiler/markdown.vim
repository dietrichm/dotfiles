let current_compiler = 'markdown'

if executable('markdown')
    CompilerSet makeprg=markdown\ \"%:p\"\ >\ \"%:p:r.html\"
elseif executable('Markdown.pl')
    CompilerSet makeprg=Markdown.pl\ \"%:p\"\ >\ \"%:p:r.html\"
endif
