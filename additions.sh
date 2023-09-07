#!/bin/bash
#Making pacman colourful and use parallel downloads

echo "Making pacman beautiful..."
sudo sed -i 's/#Color/Color/' /etc/pacman.conf
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf

#Enabling autologin
echo "Enabling autologin..."
sudo sed -i 's/#autologin-user=/autologin-user=chris/g' /etc/lightdm/lightdm.conf
sudo groupadd -r autologin
sudo gpasswd -a chris autologin
