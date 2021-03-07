#!/usr/bin/env bash

if [ -z "$MY_CONFIG_ROOT" ]; then
    echo "Please follow install instructions in README.md first."
    exit 1
fi

set -e

# Local file to target in ~.
declare -A files=(
    [.ignore]=.ignore
    [.tigrc]=.tigrc
    [ctags]=.config/ctags
    [git/.gitattributes_global]=.gitattributes_global
    [git/.gitconfig]=.gitconfig
    [git/.gitignore_global]=.gitignore_global
    [gpg-agent.conf]=.gnupg/gpg-agent.conf
    [kitty]=.config/kitty
    [nvim]=.config/nvim
    [ssh-config]=.ssh/config
    [tmux/tmux.conf]=.tmux.conf
)

if command -v php &> /dev/null; then
    files[phpactor]=.config/phpactor
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
tic $MY_CONFIG_ROOT/tmux-256color.terminfo \
    || echo -e "Skipped compiling terminfo for Tmux.\n"

# Install Python dependencies.
pip3.8 install --user -U -r $MY_CONFIG_ROOT/requirements.txt
echo

for file in "${!files[@]}"; do
    source="${files[$file]}"
    target="$file"

    [ "${source:0:1}" = "/" ] || source="$HOME/$source"
    [ "${target:0:1}" = "/" ] || target="$MY_CONFIG_ROOT/$target"

    if [ -h "$source" ]; then
        # Symlink exists already.
        existing=$(readlink "$source")

        if [ "$existing" = "$target" ]; then
            # Correct symlink.
            echo "Skipping $file; already installed."
            continue
        fi
    fi

    echo -n " * Install $file as $source? [y/n] "
    read install

    if [ "$install" != "y" ] && [ "$install" != "Y" ]; then
        continue
    fi

    __backup_file "$source"

    # Install symlink.
    ln -s "$target" "$source"
    echo "Installed $file as $source."
done
echo

# Install desired theme.
theme=${1:-base16-bright}
stow -v --override='.*' -d $MY_CONFIG_ROOT/themes $theme
echo "Installed $theme theme."
