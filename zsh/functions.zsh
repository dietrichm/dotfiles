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

ai() {
    local dir
    dir=$(cd "${~${1:-$PWD}}" 2>/dev/null && pwd) || return 1
    local name=${dir:t}
    local id=${${dir#$HOME/}//\//-}
    local file="$dir/$id.kitty-session"
    if [ ! -f "$file" ]; then
        local agent=${AI_AGENT:-vibe}
        if ! command -v "$agent" >/dev/null; then
            echo "ai: agent '$agent' not found (override with AI_AGENT)" >&2
            return 1
        fi

        local template
        template=$(<"${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty-session.template")
        [ -n "$template" ] || { echo "ai: missing kitty session template" >&2; return 1 }
        template=${template//__NAME__/$name}
        template=${template//__AGENT__/$agent}
        print -r -- "$template" > "$file"
    fi

    kitty @ action goto_session "$file"
    if [ -n "$KITTY_WINDOW_ID" ]; then
        kitty @ close-tab --match "window_id:$KITTY_WINDOW_ID and not var:window=agent"
    fi
}

cpj() {
    command -v fzf >/dev/null || { echo "cpj: requires fzf" >&2; return 1 }

    local dir root base
    root=$(git rev-parse --show-toplevel 2>/dev/null) && root=${root:h}
    base=${root:-$PWD}
    dir=$(find "$base" -maxdepth 2 -name .git -type d -printf '%T@ %h\n' 2>/dev/null \
        | sort -rn \
        | cut -d' ' -f2- \
        | fzf --query="${1:-}") || return 0
    print -rn "$dir" | wl-copy
    echo "Copied: $dir"
}
