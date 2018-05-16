#!/bin/bash

# Script for installing OMX player and to create structure 
# for a looping media playlist loading on boot.
# All video files need to be stored in /home/pi/Videos.

# If you need to access the pi hit ALT+TAB - OMXplayer will
# remain on top but you are now accessing the terminal that
# is launched by the relevant line in 
# /home/pi/.config/lxsession/LXDE-pi/autostart
# After hitting ALT+TAB, type Q followed by CTRL+C
# This will quit the loop and cancel the script running in
# the launched terminal

# The display can be relaunched without rebooting by 
# running the launcher this script places on your desktop

# Start script

# Update RPi & install OMXplayer (you probably have this already)

sudo apt-get update
sudo apt-get -y install omxplayer

# Making a directory to hold scripts 
# If you want you can use any other suitable name
# but don't forget to use FIND & Replace for every
# instance in this script

cd ~/
mkdir IxD
cd IxD

# Creating a script which will run the looping playlist in OMXPlayer
cat <<'EOF' > loopplaylist.sh
#!/bin/sh

trap exit 1 SIGINT SIGKILL SIGTERM


# set here the path to the directory containing your videos
VideoLocation="/home/pi/Videos"

Process="omxplayer --key-config=/home/pi/IxD/keyconfig.txt"

# our loop
while true; do
	if ps ax | grep -v grep | grep $Process > /dev/null
	then
	sleep 1;
else
	for entry in $VideoLocation/*
	do
		clear
		omxplayer -r $entry > /dev/null
	done

SIGINT

fi
done
EOF

# changing the file to EXECUTABLE

sudo chmod +x loopplaylist.sh

# Adding config file to permit keybindings

cat <<EOF > keyconfig.txt
EXIT:esc
PAUSE:p
#Note that this next line has a space after the :
PAUSE:
REWIND:left
SEEK_FORWARD_SMALL:hex 0x4f43
EXIT:q
EOF

# Heading to desktop to make a launcher file

cd ~/Desktop

# Creating the launcher

cat <<EOF > IxD_Launcher.desktop
[Desktop Entry]
Version=1.0
Name=IxD Looping Video
Comment=Looping video player for IxD monitors - NCAD. Place videos in /home/pi/Videos. Played in alphabetical order.
Exec=/home/pi/IxD/loopplaylist.sh
Icon=/home/pi/IxD/your_logo.jpg
Path=/home/pi/IxD
Terminal=true
Type=Application
Categories=Utility;Application;
EOF

# Making it run on boot
# Backing up autostart file to have copy for removal of utility
cp ~/.config/lxsession/LXDE-pi/autostart ~/.config/lxsession/LXDE-pi/autostart.bk

# Inserting boot script to ~/.config/lxsession/LXDE-pi/autostart
# This will place it in the middle of the script (needs to be before screensaver)
cd ~/.config/lxsession/LXDE-pi/
sed -i '/^@pcmanfm/a @lxterminal -e /home/pi/IxD/loopplaylist.sh' autostart

cd ~/OMXLoopPlaylist
mv your_logo.jpg ~/IxD/your_logo.jpg

echo "And it's that easy"
echo "Just load videos into /home/pi/Videos and reboot"
echo "If you want an image to appear as the desktop launcher "
echo "just place one in the home/pi/IxD folder and call it your_logo.jpg"
