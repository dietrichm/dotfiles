loadkey() {
    local key="id_rsa"

    if [ $# -ge 1 ]; then
        key="$1"
    fi

    ssh-add ~/.ssh/"$key" < /dev/null
}

stt() {
    local title="${PWD##*/}"

    kitty @ set-tab-title "$title"
}
