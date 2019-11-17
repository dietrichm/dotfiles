#!/usr/bin/env bash

restic backup \
  -e "/home/dietrich/.*" \
  -e "/home/dietrich/Afbeeldingen" \
  -e "/home/dietrich/repos/dotfiles/nvim/plugged" \
  -e "/home/dietrich/snap" \
  -e ".git" \
  /home/dietrich
