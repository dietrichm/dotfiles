precmd() {
    echo -ne "\033]0;${PWD/#$HOME/~}\007"
}

ctags() {
    command ctags "$@" 2> >(
        grep -Ev "^ctags: Warning: ignoring null tag in .+\.js\(line: .+\)$"
    )
}

ca() {
    conda activate "$(basename "$PWD")"
}

repos() {
    local name="repos"
    local dir=~/repos

    tmux new-session -A -c "$dir" -s "$name"
}
