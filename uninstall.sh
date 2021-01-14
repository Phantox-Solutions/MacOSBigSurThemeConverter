#!/bin/bash

#Removing Existing Configs
sudo rm -r ~/.config/lxpanel
sudo rm -r ~/.config/lxterminal
sudo rm -r ~/.config/lxsession
sudo rm -r ~/.config/pcmanfm

#restoring backups
cp -r  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/lxpanel ~/.config
cp -r  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/lxsession ~/.config
cp -r  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/lxterminal ~/.config
cp -r  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/pcmanfm ~/.config

#Removing autostart shortcuts
sudo rm /home/pi/.config/autostart/MacOSBigSurThemeConverterAutostart.desktop

#Removing Gtk Themes
rm -r ~/.themes/WhiteSur-dark/
rm -r ~/.themes/WhiteSur-light/

#Removing Icon Themes
rm -r ~/.local/share/icons/BigSur/
rm -r ~/.local/share/icons/BigSur-dark/

#Removing Cursors
sudo rm -r /usr/share/icons/BigSur-Originals-Cursor/

#Removing Plank Theme
rm -r ~/.local/share/plank/themes/mcOS-BS-Black-Stock/
rm -r ~/.local/share/plank/themes/mcOS-BS-White-Stock/

#Removing Ulauncher, xfce4-panel-profiles, lightpad
sudo apt purge ulauncher xfce4-panel-profiles lightpad

#Removing Network Manager
sudo sed -i '/denyinterfaces wlan0/c\ ' /etc/dhcpcd.conf 
sudo sed -i '/[main]/,/managed=true/d' /etc/NetworkManager/NetworkManager.conf 

#Restoring Default Desktop File For Chromium
sudo sed -i '/Icon/c\Icon=chromium-browser' /usr/share/applications/chromium-browser.desktop

echo "Finished Restoring Config Files.Refreshing desktop session now, but rebooting is recommended."

#Refreshing Desktop Session
killall lxpanel plank xfwm4 &>/dev/null
sudo update-icon-caches /usr/share/icons/*
openbox &>/dev/null &
pcmanfm --desktop --profile LXDE-pi &>/dev/null &
pcmanfm --reconfigure
lxpanel --profile LXDE-pi &>/dev/null &
