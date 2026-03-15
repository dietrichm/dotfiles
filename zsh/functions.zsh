pdfcompress() {
    if [ $# -lt 2 ]; then
        echo "Usage: $0 <input-file> <output-file>"
        return 1
    fi

    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dQUIET -dNOPAUSE -dBATCH -sOutputFile="$2" "$1"
    ls -lh "$1" "$2"
}

update-nvim-nightly() {
    make -C "$MY_CONFIG_ROOT" $0
}
