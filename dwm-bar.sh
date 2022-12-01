#!/bin/bash

dwm_date () {
    DATE="$(date "+%a %d-%m-%y %T")"
    printf "%s" "$DATE"
}

dwm_volume () {
    VOL="$(pulsemixer --get-volume)"
    printf "VOL: %d%%" "$VOL"
    [ "$(pulsemixer --get-mute)" = "1" ] && printf " MUTED"
}

dwm_network () {
    CONNAME=$(nmcli -a | grep 'Wired connection' | awk 'NR==1{print $1}')
    if [ "$CONNAME" = "" ]; then
        CONNAME=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -c 5-)
    fi
    CONNAME=${CONNAME::-1}

    PRIVATE=$(nmcli -a | grep 'inet4 192' | awk '{print $2}')
    PRIVATE=${PRIVATE%/*}
    printf "NET %s (%s)" "${PRIVATE}" "${CONNAME}"
 }

while true; do
  xsetroot -name "$(dwm_network) | $(dwm_volume) | $(dwm_date)"
  sleep 1
done