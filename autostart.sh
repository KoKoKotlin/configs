#!/bin/bash
# dwm (X11) session autostart; not used on Wayland/Hyprland.

xrandr --output DP-0 --right-of HDMI-0
picom &
slstatus &
feh --bg-fill ~/Pictures/958729-Arch-Linux-Linux-open-source.png
