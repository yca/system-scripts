#!/bin/bash

DELAY=0.2

function find_window()
{
	echo $(wmctrl -l | grep -i "$1" | cut -d " " -f 1)
}

function mvw_right()
{
	wmctrl -ir $1 -b remove,maximized_vert,maximized_horz
	wmctrl -ir $1 -e 0,2000,0,200,200
	wmctrl -ir $1 -b add,maximized_vert,maximized_horz
}

#This function splits current dolphin tab into 2
function dolphin_split()
{
	xdotool windowactivate $1
	xdotool key 'F3'
	xdotool key 'ctrl+l'
	xdotool type $2
	xdotool key Return
	sleep $DELAY
}

#This function sets current directory of dolphin
function dolphin_setdir()
{
	xdotool windowactivate $1
	xdotool key 'ctrl+l'
	xdotool type $2
	xdotool key Return
	sleep $DELAY
}

#creates a new tab in dolphin.
#Example: Following command creates a new tab with splitted into 2
#	dolphin_newtab $dolphin "/home/caglar/myfs" "/home/caglar/myfs/temp"
#If you want to create an unsplitted tab leave last parameter as empty
function dolphin_newtab()
{
	xdotool windowactivate $1
	xdotool key 'ctrl+t'
	sleep $DELAY
	dolphin_setdir $1 $2
	
	if [[ $3 != "" ]]
	then
		dolphin_split $1 $3
	fi
}

function dolphin_clean_and_open()
{
	#close all instances of dolphin, create a new one, adjust its folders and move to the right monitor
	window_close_all "dolphin"
	dolphin &
	sleep 0.5
	dolphin=$(find_window "dolphin")
	dolphin_setdir $dolphin $1
	dolphin_split $dolphin $2
	if [[ "$3" != "" ]] ; then dolphin_newtab $dolphin $3 $4 ; fi
	if [[ "$5" != "" ]] ; then dolphin_newtab $dolphin $5 $6 ; fi
	if [[ "$7" != "" ]] ; then dolphin_newtab $dolphin $7 $8 ; fi
	mvw_right $dolphin
}

function konsole_setdir()
{
	xdotool windowactivate $1
	xdotool type "cd "
	xdotool type $2
	xdotool key Return
	sleep $DELAY
}

function konsole_newtab()
{
	xdotool windowactivate $1
	xdotool key 'ctrl+shift+t'
	sleep $DELAY
	konsole_setdir $1 $2
}

function konsole_clean_and_open()
{
	#Close all instances of konsole
	window_close_all "konsole"
	konsole &
	sleep 0.5
	konsole=$(find_window "konsole")
	konsole_setdir $konsole $1
	if [[ "$2" != "" ]] ; then konsole_newtab $konsole $2 ; fi
	if [[ "$3" != "" ]] ; then konsole_newtab $konsole $3 ; fi
	if [[ "$4" != "" ]] ; then konsole_newtab $konsole $4 ; fi
	if [[ "$5" != "" ]] ; then konsole_newtab $konsole $5 ; fi
	if [[ "$6" != "" ]] ; then konsole_newtab $konsole $6 ; fi
	if [[ "$7" != "" ]] ; then konsole_newtab $konsole $7 ; fi
	if [[ "$8" != "" ]] ; then konsole_newtab $konsole $8 ; fi
}

#This function closes all instances of dolphin
function window_close_all()
{
	windows=$(find_window $1)
	for wd in $windows
	do
		wmctrl -ic $wd
	done
	sleep $DELAY
}

function qtc_open_session()
{
	xdotool windowactivate $1
	xdotool key 'ctrl+shift+m'
	sleep $DELAY
	xdotool type $2
	sleep $DELAY
	xdotool key 'alt+s'
}

function qtc_clean_and_open()
{
	#close all instances of qt creator, open a new one and select utest session
	window_close_all "Qt Creator"
	qtcreator &
	sleep 2
	qtc=$(find_window "Qt Creator")
	qtc_open_session $qtc $1
}

function chrome_show_bookmarks()
{
	#Open a new bookmark tab in chrome so that desired session can be loaded as new tabs
	chromium $HOME &
	sleep 1
	chromium=$(find_window "chromium")
	xdotool windowactivate $chromium
	xdotool key 'ctrl+e'
	xdotool key BackSpace
	xdotool type "chrome://bookmarks/#$1"
	xdotool key Return
}

if [[ "$1" == "utest" ]]
then
	echo "restoring utest workspace"

	konsole_clean_and_open "/home/caglar/myfs/source-codes/bilkon/UTestUi/" "/home/caglar/myfs/source-codes/bilkon/build_dm6446/utestui" "/home/caglar/myfs/temp"
	chrome_show_bookmarks "146"
	qtc_clean_and_open "utest"
	dolphin_clean_and_open \
		"/home/caglar/myfs/source-codes/bilkon/UTestUi/" \
		"/home/caglar/myfs/source-codes/bilkon/build_dm6446/utestui/" \
		"/home/caglar/Downloads" \
		"/home/caglar/myfs/tasks/"

elif [[ "$1" == "aselsan" ]]
then
	echo "restoring aselsan workspace"
elif [[ "$1" == "oper" ]]
then
	echo "restoring operec workspace"
else
	sel=$(kdialog --title "Select your destiny" --combobox "Select your session:" "utest" "aselsan" "operec")
	if [[ "$sel" != "" ]]
	then
		$0 $sel
	fi
fi

#virtualbox --startvm winxp

