precmd() {
    echo -ne "\033]0;${PWD/#$HOME/~}\007"
}

ctags() {
    command ctags "$@" 2> >(
        grep -Ev "^ctags: Warning: ignoring null tag in .+\.js\(line: .+\)$"
    )
}
