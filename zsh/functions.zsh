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

cpj() {
    command -v fzf >/dev/null || { echo "cpj: requires fzf" >&2; return 1 }

    local dir root
    root=$(git rev-parse --show-toplevel 2>/dev/null) && root=${root:h}
    dir=$(find "${root:-$PWD}" -maxdepth 2 -name .git -type d -printf '%T@ %h\n' 2>/dev/null \
        | sort -rn \
        | cut -d' ' -f2- \
        | fzf --query="${1:-}") || return 0
    print -rn "$dir" | wl-copy
    echo "Copied: $dir"
}
