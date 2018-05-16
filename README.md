# OMXLoopPlaylist

This is a pretty simple script. Lots of notes inside it if you're interested.

## What's it do?

It's written and tested on Raspberry Pi though I expect it will work on any Debian based linux.
### The script...
*Installs omxplayer

*Creates a folder (called IxD) and a few files inside, one of which is a script to alphanumerically play videos in the /home/pi/Videos directory as if they were a playlist - and in a loop.

*Creates a desktop launcher if you want to run it from there instead of running at boot

*Inserts a line into /home/pi/.config/lxsession/LXDE-pi/autostart to start omxplayer looping

## To install, open terminal and:

`sudo apt-get install -y git` (though you probably have that if you're here)

`git clone https://github.com/TonyCanning/OMXLoopPlaylist.git`

`cd OMXLoopPlaylist`

`sudo chmod +x IxDmedialooper.sh`

`./IxDmedialooper.sh`
