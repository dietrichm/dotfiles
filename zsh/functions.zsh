precmd() {
    echo -ne "\033]0;${PWD/#$HOME/~}\007"
}

loadkey() {
    local key="id_rsa"

    if [ $# -ge 1 ]; then
        key="$1"
    fi

    ssh-add ~/.ssh/"$key" < /dev/null
}
