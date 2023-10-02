#!/bin/bash

connected_devices=$(bluetoothctl paired-devices)
while read -r line; do
  uuid=$(echo "$line" | awk '{print $2}')
  connected=$(bluetoothctl info "$uuid" | grep -i 'Connected: yes')

  if [ -n "$connected" ]; then
    device_name=$(bluetoothctl info "$uuid" | awk -F 'Name: ' '/Name/ {print $2}')
    echo "$device_name"
  fi
done <<< "$connected_devices"
