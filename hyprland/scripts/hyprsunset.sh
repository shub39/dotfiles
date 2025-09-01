#!/bin/bash

if pgrep -x hyprsunset >/dev/null; then
    pkill -x hyprsunset
else
    hyprsunset -t 4500 &
fi

