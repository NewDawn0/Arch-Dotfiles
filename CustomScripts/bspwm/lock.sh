#!/bin/bash
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"
xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 300 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .1' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  --timer 10 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1; betterlockscreen --lock' \
    '' \
  --timer 3600 \
    'systemctl suspend' \
    ''
