#!/bin/bash

COMB1='DVI-0<->VGA-0'

if [[ "$1" == "$COMB1" ]]
then
	/usr/bin/xrandr --output DVI-0 --primary --auto --output VGA-0 --right-of DVI-0 --auto
else
	sel=$(kdialog --title "Select your monitors" --combobox "Monitor combination:" $COMB1)
	if [[ "$sel" != "" ]]
	then
                $0 $sel
        fi
fi

