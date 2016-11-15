#!/bin/bash

COMB1='DVI<->VGA'

if [[ "$1" == "$COMB1" ]]
then
	/usr/bin/xrandr --output HDMI2 --primary --auto --output VGA1 --right-of HDMI2 --auto
else
	sel=$(kdialog --title "Select your monitors" --combobox "Monitor combination:" $COMB1)
	if [[ "$sel" != "" ]]
	then
                $0 $sel
        fi
fi

