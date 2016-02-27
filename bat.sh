#!/bin/bash                                                          

# Battery level warning script

battery_level=`acpi -b | grep -oP '[0-9]+(?=%)'`

if [[ $battery_level -le 100  && $battery_level -gt 90 ]]; then
    notify-send "Battery low warning" "Battery level is ${battery_level}%"
fi

if [[ $battery_level -le 60 && $battery_level -gt 10 ]]; then
    notify-send "Battery low warning" "Battery level is ${battery_level}%"
elif [[ $battery_level -le 10 && $battery_level -gt 5 ]]; then
    notify-send "Battery very low warning" "Battery level is ${battery_level}% Use ac power now, or shutdown is imminent - close applications"
elif [[ $battery_level -le 5 ]]; then
    # our custom actions for critical battery level
    notify-send "Battery critical warning" "Battery level is ${battery_level}% Shutting system down now"
fi

