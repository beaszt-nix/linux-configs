#!/bin/bash

if [[ $(pgrep spotify) ]]
then
	status="$(playerctl status)"
	if [[ "$status" = *Playing* ]]
	then
		echo -e "%{F#dda9aeb4}"
	elif [[ "$status" = *Paused* ]]
	then
		echo -e "%{F#dda9aeb4}"
	fi
else
	echo -e "%{F#dda9aeb4}"
fi
