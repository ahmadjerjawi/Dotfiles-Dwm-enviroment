#!/bin/bash

# Check if script is running as sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as sudo"
  exit
fi

# Check for local and config files and move them to .local and .config
for dir in local config; do
  if [ -d "$dir" ] && [ ! -d ".$dir" ]; then
    mv "$dir" ".$dir"
  fi
done

# Install dwm, dwmblocks, st, and dmenu
for prog in dwm dwmblocks st dmenu; do
  cd ~/.local/src/$prog
  sudo make clean install
done

# Remove specified programs
sudo pacman -Rns librewolf newsboat abook lf neomutt

# Install specified programs
sudo pacman -S chromium nemo ttf-nerd-fonts-symbols atuin
