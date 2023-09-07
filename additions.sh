#!/bin/bash
read -p "What is your username? " USER

#Making pacman colourful and use parallel downloads

#function check_programs() {
#	echo "Checking for needed programs..."
#	if [ "$(pacman -Q | awk '/xfconf-query/ {print }'|wc -l)" -e 0 ]
#	then
 #       	echo "Installing xfconf-query..."
#	        sudo pacman -S xfconf-query
 #       	sleep 2
#	else
 #       	echo "All needed programs are installed."
#	        sleep 2
#	fi
#}

echo "Making pacman beautiful..."
sed -i 's/#Color/Color/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf

#Enabling autologin
echo "Enabling autologin..."
sed -i "s/#autologin-user=/autologin-user=${USER}/g" /etc/lightdm/lightdm.conf
groupadd -r autologin
gpasswd -a ${USER} autologin

#Changing desktop background
mkdir /home/${USER}/Pictures
cp background.jpg /home/${USER}/Pictures
xfconf-query -c xfce4-desktop -p  /backdrop/screen0/monitor0/workspace0/last-image -s /home/${USER}/Pictures/background.jpg
