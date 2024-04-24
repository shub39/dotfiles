#!/usr/bin/bash

killall scrcpy
notify-send "SCRCPY is running!"
scrcpy -S
notify-send "SCRCPY closed :("
