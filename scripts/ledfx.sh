#!/bin/bash

if pgrep -x ledfx >/dev/null; then
    pkill -x ledfx
else
    cd ~/Programs/ledfx/
    uv run ledfx   
fi

