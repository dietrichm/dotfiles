#!/usr/bin/env bash

if [ -z "$MY_CONFIG_ROOT" ]; then
    echo "Please follow install instructions in README.md first."
    exit 1
fi

set -e

theme=${1:-default}
shift || true

all_packages=(
    dig
    direnv
    git
    kitty
    nvim
    ranger
    ssh
    tig
)

if [ $# -ge 1 ]; then
    selected_packages=("$@")
else
    selected_packages=("${all_packages[@]}")
fi

# Install desired theme.
stow -v2 --override='.*' -d "$MY_CONFIG_ROOT/themes" "$theme"
echo -e "Installed $theme theme.\n"

stow -v2 -d "$MY_CONFIG_ROOT" -t "$HOME" "${selected_packages[@]}"
