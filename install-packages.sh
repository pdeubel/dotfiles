#!/bin/bash

# Install some basic packages while also updating the system, do not use
# --noconfirm here, but for the rest
sudo pacman -Syu \
   base-devel git nextcloud-client tlp tlp-rdw yay \
   chromium firefox thunderbird \
   vim kate konsole kdeconnect kile okular spectacle \
   borg keepassxc seahorse gnome-keyring \
   dolphin ark ranger \
   networkmanager network-manager-applet \
   exa dunst feh picom polybar rofi ttf-font-awesome ttf-hack noto-fonts

# This will also require user input, but I guess here it is fine as it
# downloads packages from AUR
yay -S anki i3lock-fancy-rapid-git rofi-greenclip spotify

# Setup instructions for TLP
systemctl enable tlp.service
systemctl enable NetworkManager-dispatcher.service

systemctl mask systemd-rfkill.service systemd-rfkill.socket
