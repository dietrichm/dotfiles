loadkey() {
    local key="id_rsa"

    if [ $# -ge 1 ]; then
        key="$1"
    fi

    SSH_ASKPASS=ksshaskpass ssh-add ~/.ssh/"$key" < /dev/null
}

pdfcompress() {
    if [ $# -lt 2 ]; then
        echo "Usage: $0 <input-file> <output-file>"
        return 1
    fi

    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dQUIET -dNOPAUSE -dBATCH -sOutputFile="$2" "$1"
    ls -lh "$1" "$2"
}
