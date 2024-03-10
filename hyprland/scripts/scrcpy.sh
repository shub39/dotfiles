#!/usr/bin/zsh

killall scrcpy
notify-send "SCRCPY is running!"
scrcpy -S
notify-send "SCRCPY closed :("