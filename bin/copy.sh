#!/usr/bin/env bash

set -e

tmux_yank_helpers="$HOME/.tmux/plugins/tmux-yank/scripts/helpers.sh"
source "$tmux_yank_helpers"

eval "$(clipboard_copy_command)"
