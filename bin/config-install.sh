#!/usr/bin/env zsh

if [ -z "$MY_CONFIG_ROOT" ]; then
    echo "Please follow install instructions in README.md first."
    exit 1
fi

set -e

theme=default

if [ $# -ge 1 ]; then
    theme="$1"
    shift
fi

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
selected_packages=("${all_packages[@]}")

if [ $# -ge 1 ]; then
    selected_packages=("$@")
fi

# Install desired theme.
stow -v2 --override='.*' -d "$MY_CONFIG_ROOT/themes" "$theme"
echo -e "Installed $theme theme.\n"

stow -v2 -d "$MY_CONFIG_ROOT" -t "$HOME" "${selected_packages[@]}"
