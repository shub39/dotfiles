#!/bin/bash

killall scrcpy
notify-send "SCRCPY is running! but you cant see me."
scrcpy --no-video
notify-send "SCRCPY is dead :("
