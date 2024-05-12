#!/usr/bin/bash

#Script to run SCRCPY

if pgrep -x "scrcpy" > /dev/null
then
    pkill -x scrcpy
    exit
fi

options="Video\nNo Video"

selected_option=$(echo -e "$options" | rofi -dmenu -config ~/.config/dotfiles/rofi/config.rasi -p "Select SCRCPY mode: ")

case "$selected_option" in
    "Video")
      scrcpy -S
        ;;
    "No Video")
      scrcpy --no-video
        ;;
    *)
        echo "Invalid selection"
        ;;
esac
