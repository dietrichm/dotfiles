loadkey() {
    local key="id_rsa"

    if [ $# -ge 1 ]; then
        key="$1"
    fi

    ssh-add ~/.ssh/"$key" < /dev/null
}

stt() {
    local title="${PWD##*/}"

    if [ $# -ge 1 ]; then
        title="$title $1"
    fi

    kitty @ set-tab-title "$title"
}
