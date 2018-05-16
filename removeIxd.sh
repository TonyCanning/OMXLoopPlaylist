#!/bin/bash

# remove folders
cd ~/
sudo rm -r IxD
sudo rm -r OMXLoopPlaylist

# remove desktop launcher
sudo rm -r Desktop/IxD_Launcher.desktop

# restore back up autostart file
cd ~/.config/lxsession/LXDE-pi/
mv autostart.bk autostart

echo "			All done......"
