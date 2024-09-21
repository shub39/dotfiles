#!/usr/bin/bash

#Script to run SCRCPY

if pgrep -x "scrcpy" > /dev/null
then
    pkill -x scrcpy
    exit
fi

options="Video\nNo Video\nVideo & Audio"

selected_option=$(echo -e "$options" | rofi -dmenu -config ~/.config/dotfiles/rofi/config.rasi -p "Select SCRCPY mode: ")

case "$selected_option" in
    "Video")
      scrcpy --max-size=1024 --video-codec=h265 --video-bit-rate=6M --audio-bit-rate=128K --max-fps=30 --no-audio
        ;;
    "No Video")
      scrcpy --no-window
        ;;
    "Video & Audio")
      scrcpy --max-size=1024 --video-codec=h265 --video-bit-rate=6M --audio-bit-rate=128K --max-fps=30
        ;;
    *)
        echo "Invalid selection"
        ;;
esac
