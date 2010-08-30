#!/bin/bash
# From Red_Lion post #576:  http://ubuntuforums.org/showthread.php?t=845911&page=58

old="0"
stylus='Serial Wacom Tablet'

while true; do
	if [[ -e /sys/devices/platform/hp-wmi/tablet ]]; then
		new=`cat /sys/devices/platform/hp-wmi/tablet`
		if [[ $new != $old ]]; then
			if [[ $new == "0" ]]; then
				echo "Rotate to landscape"
				#cellwriter --hide-window
				xrandr -o normal 
				xsetwacom set "$stylus" rotate NONE 
			elif [[ $new == "1" ]]; then
				echo "Rotate to portrait"
				#cellwriter --show-window
				xrandr -o right 
				xsetwacom set "$stylus" rotate CW 
			fi 
		fi
		old=$new
		sleep 1s
	fi
done
