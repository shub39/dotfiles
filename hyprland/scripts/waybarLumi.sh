#!/bin/bash

killall waybar
waybar -c ~/.config/dotfiles/waybar/lumi-config -s ~/.config/dotfiles/waybar/style.css &
