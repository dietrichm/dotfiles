#!/usr/bin/env bash

set -e

tmux_yank_helpers="$HOME/.tmux/plugins/tmux-yank/scripts/helpers.sh"

if [ ! -f "$tmux_yank_helpers" ]; then
    echo "tmux-yank is not installed!"
    exit 1
fi

source "$tmux_yank_helpers"

eval "$(clipboard_copy_command)"
