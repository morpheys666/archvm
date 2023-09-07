#! /bin/bash
#Deinstall open-vm-tools
echo "Uninstalling open-vm-tools..."
sudo pacman -R open-vm-tools
sleep 2

#create fake /etc/init.d/rc*.d directories
echo "Creating fake /etc/init.d/rc*.d directories..."
 for x in {0..6}; do sudo mkdir -p /etc/init.d/rc${x}.d; done
sleep 2

#download vmware-tools
echo "Downloading and extracting VMware Tools..."
curl -H ‘X-Requested-With: XMLHttpRequest’ -o vmware-tools.tar.gz "https://brch1005.ddns.net/index.php/s/j49AdQQGX6tfyj7/download" | tar xvzf -
sleep 2

echo "Installing VMware Tools..."
sudo ./vmware-install.pl
clear

echo "Installing and enabling system service..."
sudo cp vmwaretools.service  /etc/systemd/system/
sudo systemctl enable --now vmwaretools.service
echo "Done... A reboot is advised."
sleep 2
while true; do
read -p "Do you want to reboot now? (y/n) " yn
case $yn in
	[yY] ) echo "Rebooting now...";
		break;;
	[nN] ) echo "Exiting...";
		exit;;
	* ) echo "Invalid response";;
esac
done
sudo reboot

