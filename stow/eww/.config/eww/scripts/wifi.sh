#!/usr/bin/env bash
STATUS=$(nmcli | grep 'eth0\|enp7s0' | awk 'FNR == 1 {print $2}')
toggle() {
    if [[ $STATUS == "conectado" ]]; then
        nmcli device disconnect eth0  # Replace 'eth0' with your actual Ethernet device name
        notify-send --icon=window-close --urgency=normal "Ethernet" "Ethernet has been disconnected!"
    else
        nmcli device connect eth0  # Replace 'eth0' with your actual Ethernet device name
        notify-send --icon=checkmark --urgency=normal "Ethernet" "Ethernet has been connected, you are back online!"
    fi
}

class() {
    if [[ $STATUS == "conectado" ]]; then
        echo active
    else
        echo inactive
    fi
}

color() {
    if [[ $STATUS == "conectado" ]]; then
        echo "green"
    else
        echo "red"
    fi
}

icon() {
    if [[ $STATUS == "conectado" ]]; then
        echo "󰈀"
    else
        echo "󰈂 "
    fi
}

if [[ $1 == "--toggle" ]]; then
    toggle
elif [[ $1 == "--class" ]]; then
    class
elif [[ $1 == "--color" ]]; then
    color
elif [[ $1 == "--icon" ]]; then
    icon
fi

