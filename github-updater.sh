#!/bin/bash

# Check if local file exists, if not, create it
if [ ! -f local ]; then
    touch local
fi

# Check if config file exists, if not, create it
if [ ! -f config ]; then
    touch config
fi

# Retrieve specified files from ~/.local/
mkdir -p local
cp -r ~/.local/src local/
cp -r ~/.local/bin local/
cp -r ~/.local/share/bg local/share
cp -r ~/.local/share/larbs local/share
cp ~/.zshrc local/
cp ~/.zprofile local/

# Retrieve specified files from ~/.config/
mkdir -p config
cp -r ~/.config/mpv config/
cp -r ~/.config/ncmpcpp config/
cp -r ~/.config/nvim config/
cp -r ~/.config/pinentry config/
cp -r ~/.config/pipewire config/
cp -r ~/.config/pulse config/
cp -r ~/.config/python config/
cp -r ~/.config/shell config/
cp -r ~/.config/wal config/
cp -r ~/.config/wget config/
cp -r ~/.config/x11 config/
cp -r ~/.config/zathura config/

# Add changes to git
git add local config

# Make a git commit
git commit -m "Updated local and config files"

# Push changes to remote repository
git push origin main
