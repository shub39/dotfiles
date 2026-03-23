#!/bin/bash

if pgrep -x wlsunset >/dev/null; then
    pkill -x wlsunset
else
    wlsunset  -t 4000 -T 4001 &
fi
