#!/bin/sh

xrdb merge ~/.Xresources
xbacklight -set 10 &
feh --bg-max -z ~/Downloads/wallpapers/ &
xset r rate 200 50 &
xrandr --output HDMI-A-0 --left-of DisplayPort-2 &
picom &

~/.config/chadwm/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
