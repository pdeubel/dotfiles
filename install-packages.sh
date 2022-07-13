#!/bin/bash

# Install some basic packages while also updating the system, do not use
# --noconfirm here, but for the rest
sudo pacman -Syu base-devel git nextcloud-client tlp tlp-rdw yay

sudo pacman -S --noconfirm chromium firefox thunderbird

sudo pacman -S --noconfirm vim kate kdeconnect kile okular spectacle

sudo pacman -S --noconfirm borg keepassxc seahorse gnome-keyring

sudo pacman -S --noconfirm dolphin ark ranger

sudo pacman -S --noconfirm networkmanager network-manager-applet

sudo pacman -S --noconfirm exa dunst nitrogen picom polybar rofi ttf-hack

# This will also require user input, but I guess here it is fine as it
# downloads packages from AUR
yay -S anki i3lock-fancy-rapid-git rofi-greenclip spotify

# Setup instructions for TLP
systemctl enable tlp.service
systemctl enable NetworkManager-dispatcher.service

systemctl mask systemd-rfkill.service systemd-rfkill.socket
