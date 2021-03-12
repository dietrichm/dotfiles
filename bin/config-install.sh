#!/usr/bin/env bash

if [ -z "$MY_CONFIG_ROOT" ]; then
    echo "Please follow install instructions in README.md first."
    exit 1
fi

set -e

# Local file to target in ~.
declare -A files=(
    [kitty/.config/kitty]=.config/kitty
    [nvim/.config/ctags]=.config/ctags
    [nvim/.config/nvim]=.config/nvim
    [nvim/.ignore]=.ignore
    [nvim/.ripgrep.conf]=.ripgrep.conf
    [tig/.config/tig]=.config/tig
    [tmux/.tmux.conf]=.tmux.conf
)

if command -v php &> /dev/null; then
    files[nvim/.config/phpactor]=.config/phpactor
fi

__backup_file() {
    local source=$1

    if [ ! -e "$source" ]; then
        if [ -L "$source" ]; then
            rm "$source"
            echo "Removed broken symlink $source."
        fi

        return
    fi

    # File exists already (link, file, directory).
    mv "$source" "$source.backup"
    echo "Backed up $source as $source.backup."
}

# Compile and install terminfo file for Tmux.
tic "$MY_CONFIG_ROOT/etc/tmux-256color.terminfo" \
    || echo -e "Skipped compiling terminfo for Tmux.\n"

# Install Python dependencies.
pip3.8 install --user -U -r "$MY_CONFIG_ROOT/etc/requirements.txt"
echo

for file in "${!files[@]}"; do
    source="$HOME/${files[$file]}"
    target="$MY_CONFIG_ROOT/$file"

    source_directory="$(dirname "$source")"
    relative_target="$(realpath --relative-to="$source_directory" "$target")"

    if [ -h "$source" ]; then
        # Symlink exists already.
        existing="$(readlink "$source")"

        if [ "$existing" = "$relative_target" ]; then
            # Correct symlink.
            echo "Skipping $file; already installed."
            continue
        fi
    fi

    echo -n " * Install $file as $source? [y/n] "
    read -r install

    if [ "$install" != "y" ] && [ "$install" != "Y" ]; then
        continue
    fi

    __backup_file "$source"

    # Install symlink.
    ln -s "$relative_target" "$source"
    echo "Installed $file as $source."
done
echo

stow -v2 -d "$MY_CONFIG_ROOT" -t "$HOME" git ssh
echo

# Install desired theme.
theme=${1:-base16-bright}
stow -v --override='.*' -d "$MY_CONFIG_ROOT/themes" "$theme"
echo "Installed $theme theme."
