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

pdfcompress() {
    if [ $# -lt 2 ]; then
        echo "Usage: $0 <input-file> <output-file>"
        return 1
    fi

    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dQUIET -dNOPAUSE -dBATCH -sOutputFile="$2" "$1"
    ls -lh "$1" "$2"
}
