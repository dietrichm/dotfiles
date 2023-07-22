#!/usr/bin/env bash

if [ -z "$MY_CONFIG_ROOT" ]; then
    echo "Please follow install instructions in README.md first."
    exit 1
fi

set -e

all_packages=(
    dig
    direnv
    git
    kitty
    nvim
    ssh
    tig
)

if [ -n "$2" ]; then
    IFS=',' read -r -a selected_packages <<< "$2"
else
    selected_packages=("${all_packages[@]}")
fi

# Install Python dependencies.
pip3 install --user -U -r "$MY_CONFIG_ROOT/etc/requirements.txt"
echo

# Install desired theme.
theme=${1:-papercolor}
stow -v2 --override='.*' -d "$MY_CONFIG_ROOT/themes" "$theme"
echo -e "Installed $theme theme.\n"

stow -v2 -d "$MY_CONFIG_ROOT" -t "$HOME" "${selected_packages[@]}"
