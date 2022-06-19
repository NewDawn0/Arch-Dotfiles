#!/bin/bash
source /home/dawn/CustomScripts/audio/mute.txt
if [ $mute -eq 0 ]; then
    echo "### Mute config" > /home/dawn/CustomScripts/audio/mute.txt
    echo "mute=1" >> /home/dawn/CustomScripts/audio/mute.txt
    pamixer --mute
    dunstify --urgency=low "Muted Volume"
else
    echo "### Mute config" > /home/dawn/CustomScripts/audio/mute.txt
    echo "mute=0" >> /home/dawn/CustomScripts/audio/mute.txt
    pamixer --unmute
    dunstify --urgency=low "Unmuted Volume"
fi
