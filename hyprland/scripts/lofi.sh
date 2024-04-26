#!/bin/bash

if pgrep -x "mpv" > /dev/null
then
    killall mpv
    notify-send "Killed Lofi..."
else
    notify-send "Lofi started..."
    mpv "https://play.streamafrica.net/lofiradio" --volume=50
fi

