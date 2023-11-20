#!/usr/bin/env sh

# Consulta el estado actual de la variable trayrev
current_state=$(eww state | grep trayrev)

if [[ $current_state == *"false"* ]]; then
    # Si la variable contiene "false", la cambiamos a "true"
    eww update trayrev=true
    echo "trayrev: true"
else
    # Si no contiene "false", la cambiamos a "false"
    eww update trayrev=false
    echo "trayrev: false"
fi

