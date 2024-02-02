if [ "$(pacman -Q | awk '/paru/ {print }'|wc -l)" -ge 1 ]
then
	echo "Already installed... Nothing to do..."
	sleep 2
else
  sudo pacman -S --needed base-devel
	git clone https://aur.archlinux.org/paru.git
 cd paru
 makepkg -si
	sleep 2
fi
