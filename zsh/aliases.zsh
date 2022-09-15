alias go-updates-direct='go list -m -mod=readonly -u -f "{{if and .Update (not .Indirect)}}{{.}}{{end}}" all'
alias go-updates='go list -m -mod=readonly -u -f "{{if .Update}}{{.}}{{end}}" all'
alias info='info --vi-keys'
alias largest='du -hsx * | sort -rh | head -15'
alias ls='ls --color=auto'
alias rgi='rg --ignore-vcs'
alias rgiw='rg --ignore-vcs --word-regexp'
alias rgw='rg --word-regexp'
alias swagger='docker run -p 80:8080 swaggerapi/swagger-editor'
