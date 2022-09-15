precmd() {
    echo -ne "\033]0;${PWD/#$HOME/~}\007"
}

ca() {
    conda activate "$(basename "$PWD")"
}

repos() {
    local name="repos"
    local dir=~/repos

    if [ $# -ge 1 ]; then
        name="${1##*/}"
        dir="$dir/$1"
    fi

    if [ ! -d "$dir" ]; then
        echo "Non existing directory: $dir"
        return 1
    fi

    tmux new-session -A -c "$dir" -s "$name"
}

loadkey() {
    local key="id_rsa"

    if [ $# -ge 1 ]; then
        key="$1"
    fi

    ssh-add ~/.ssh/"$key" < /dev/null
}
