precmd() {
    echo -ne "\033]0;${PWD/#$HOME/~}\007"
}

ls() {
    if [ "$OSTYPE" != "linux-gnu" ]; then
        command ls "$@"
        return $?
    fi
    command ls --color "$@"
}

ctags() {
    command ctags "$@" 2> >(
        grep -Ev "^ctags: Warning: ignoring null tag in .+\.js\(line: .+\)$"
    )
}
