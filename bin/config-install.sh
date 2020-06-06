#!/usr/bin/env bash

if [ -z "$MY_CONFIG_ROOT" ]
then
    echo "Please follow install instructions in README.md first."
    exit 1
fi

set -e

# Local file to target in ~.
declare -A files=(
    [.ctags]=.ctags
    [.gitattributes_global]=.gitattributes_global
    [.gitconfig]=.gitconfig
    [.gitignore_global]=.gitignore_global
    [.ignore]=.ignore
    [.tigrc]=.tigrc
    [.tmux.conf]=.tmux.conf
    [gpg-agent.conf]=.gnupg/gpg-agent.conf
    [kitty]=.config/kitty
    [nvim]=.config/nvim
    [phpactor]=.config/phpactor
    [ssh-config]=.ssh/config
)

function __backup_file
{
    local source=$1
    if [ -e "$source" ]
    then
        # File exists already (link, file, directory).
        mv "$source" "$source.backup"
        echo "Backed up $source as $source.backup."
    fi
}

# Compile and install terminfo file for Tmux.
tic tmux-256color.terminfo || echo -e "Skipped compiling terminfo for Tmux.\n"

for file in "${!files[@]}"
do
    source="${files[$file]}"
    target="$file"
    [ "${source:0:1}" = "/" ] || source="$HOME/$source"
    [ "${target:0:1}" = "/" ] || target="$MY_CONFIG_ROOT/$target"
    if [ -h "$source" ]
    then
        # Symlink exists already.
        existing=$(readlink -f "$source")
        if [ "$existing" = "$target" ]
        then
            # Correct symlink.
            echo "Skipping $file; already installed."
            continue
        fi
    fi
    echo -n " * Install $file as $source? [y/n] "
    read install
    if [ "$install" != "y" ] && [ "$install" != "Y" ]
    then
        continue
    fi
    __backup_file "$source"
    # Install symlink.
    ln -s "$target" "$source"
    echo "Installed $file as $source."
done
