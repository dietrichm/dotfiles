#!/usr/bin/env bash

if [ -z "$MY_CONFIG_ROOT" ]; then
    echo "Please follow install instructions in README.md first."
    exit 1
fi

set -e

# Compile and install terminfo file for Tmux.
tic "$MY_CONFIG_ROOT/etc/tmux-256color.terminfo" \
    || echo -e "Skipped compiling terminfo for Tmux.\n"

# Install Python dependencies.
pip3.8 install --user -U -r "$MY_CONFIG_ROOT/etc/requirements.txt"
echo

stow -v2 -d "$MY_CONFIG_ROOT" -t "$HOME" git ssh tig kitty nvim tmux
echo

# Install desired theme.
theme=${1:-base16-bright}
stow -v2 --override='.*' -d "$MY_CONFIG_ROOT/themes" "$theme"
echo "Installed $theme theme."
