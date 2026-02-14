#!/bin/bash

TEMP=5000

if pgrep -x wlsunset >/dev/null; then
    pkill -x wlsunset
else
    wlsunset -t $TEMP &
fi