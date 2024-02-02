#! /bin/bash
clear
reboot="A reboot is needed for changes to take effect."
function reboot_now() {
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
	reboot
}

#Detecting if open-vm-tools are installed. If true, uinstall them, else continue
echo "Checking for open-vm-tools..."
if [ "$(pacman -Q | awk '/open-vm-tools/ {print }'|wc -l)" -ge 1 ]
then
	echo "Uninstalling open-vm-tools..."
	pacman -R open-vm-tools
	sleep 2
else
	echo "open-vm-tools is not installed."
	sleep 2
fi

#create fake /etc/init.d/rc*.d directories
echo "Creating fake /etc/init.d/rc*.d directories..."
 for x in {0..6}; do mkdir -p /etc/init.d/rc${x}.d; done
sleep 2

#download vmware-tools
echo "Downloading and extracting VMware Tools..."
curl -H ‘X-Requested-With: XMLHttpRequest’ -o vmware-tools.tar.gz "https://brch1005.ddns.net/index.php/s/j49AdQQGX6tfyj7/download" | tar xzf -
sleep 2

#install curl
echo "Installing curl..."
pacman -S curl

echo "Installing VMware Tools..."
./vmware-install.pl
clear

echo "Installing and enabling system service..."
cp vmwaretools.service  /etc/systemd/system/
systemctl enable --now vmwaretools.service

while true; do
read -p "Do you want to apply additions (pacman tweak, autologin)? (y/n) " yn
case $yn in
	[yY] ) 	break;;
	[nN] ) echo $reboot;
		reboot_now;
		exit;;
	* ) echo "Invalid response";;
esac
done
bash additions.sh
echo $reboot
reboot_now
