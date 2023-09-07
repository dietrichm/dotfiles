loadkey() {
    local key="id_rsa"

    if [ $# -ge 1 ]; then
        key="$1"
    fi

    ssh-add ~/.ssh/"$key" < /dev/null
}

stt() {
    local title=""

    if [ $# -ge 1 ]; then
        title="$1 in ${PWD##*/}"
    fi

    kitty @ set-tab-title "$title"
}
