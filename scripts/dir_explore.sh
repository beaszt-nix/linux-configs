#! /bin/bash
# used as a helper in mpd_rofi, used to recursively navigate through any directory structure
# Allows selection of particular file in directory returning full path.

function subdir_check(){
	ls -F "$*" | grep '/' | sed 's/\///g'
}
directory=$(sed 's|/$||' <<< "$1")
if [[ $(subdir_check "$directory") != "" ]]
then 
	pick=$(subdir_check "$directory" | rofi -dmenu -p 'Select Subdirectory' -font "$2" -columns 3 -lines 10 -padding 20 -color-window "#330b0d13, #330b0d13, #000b0d13" -color-normal "#440b0d13, #e6e6e6, #440b0d13, #880b0d13, #e6e6e6")
	directory="${directory}/${pick}"
	while [[ $(subdir_check "$directory") != "" ]]
	do
		pick=$(subdir_check "$directory" | rofi -dmenu -p 'Select Subdirectory' -font "$2" -columns 3 -lines 10 -padding 20 -color-window "#330b0d13, #330b0d13, #000b0d13" -color-normal "#440b0d13, #e6e6e6, #440b0d13, #880b0d13, #e6e6e6")
		directory="${directory}/${pick}"
	done
fi
ls -1 "$directory"
