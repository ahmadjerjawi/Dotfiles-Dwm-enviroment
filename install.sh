#!/bin/bash

# Check if script is running as sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as sudo"
  exit
fi

# Define variables environment
dotfiles_repo="https://github.com/ahmadjerjawi/Dotfiles-Dwm-envirmoent.git/"
progs_csv="https://raw.githubusercontent.com/ahmadjerjawi/Dotfiles-Dwm-envirmoent/main/progs.csv"
aur_helper="yay"  # You can change this to your preferred AUR helper
export TERM=ansi

# Clone dotfiles repository
sudo -u "$SUDO_USER" git clone --depth 1 "$dotfiles_repo" /tmp/dotfiles || exit 1
cd /tmp/dotfiles || exit 1

# Move .zshrc and .zprofile to ~/
mv .zshrc ~/
mv .zprofile ~/

# Install local and config files
mv local/* "$HOME/.local/"
mv config/* "$HOME/.config/"
chown -R "$SUDO_USER:$SUDO_USER" "$HOME/.local" "$HOME/.config"

# Install dwm, dwmblocks, st, and dmenu
for prog in dwm dwmblocks st dmenu; do
  cd ~/.local/src/$prog || continue
  sudo -u "$SUDO_USER" make clean install
done
# make zsh deafult shell
chsh -s /bin/zsh "$SUDO_USER"

# Install programs listed in progs.csv
if [ ! -f /tmp/progs.csv ]; then
  curl -Ls "$progs_csv" > /tmp/progs.csv || exit 1
fi

while IFS=, read -r tag program comment; do
  case "$tag" in
    "A") sudo -u "$SUDO_USER" $aur_helper -S --noconfirm "$program" ;;
    *) sudo pacman --noconfirm -S "$program" ;;
  esac
done < /tmp/progs.csv
# Clean up
rm -rf /tmp/dotfiles /tmp/progs.csv

echo "Installation completed."
