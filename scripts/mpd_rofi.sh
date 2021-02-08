#! /bin/bash
# Custom Rofi frontend for quickly controlling Music Player Daemon

font='IBM Plex Sans SemiBold 16'
string="ncmpcpp\n Pause\n Play\n Volume\n Select Song by Metadata\n Select Song by Directory\n Next on Playlist\n Previous on Playlist\n Add songs to playlist\n Visualizer\n Exit"

choice=$(echo -e $string |rofi -dmenu -font "$font" -p "MPD TOOLS" -columns 3 -lines 10 -padding 20 -color-window "#330b0d13, #330b0d13, #000b0d13" -color-normal "#440b0d13, #e6e6e6, #440b0d13, #880b0d13, #e6e6e6")
while [[ $choice != " Exit" ]] && [[ $choice != "" ]]
do
	case $choice in
		' Select Song by Directory')
			var=$(sh ~/.config/scripts/dir_explore.sh ~/Music/ "$font"| grep ".mp3")
			song=$(echo "$var" | rofi -dmenu -font "$font" -p "Select Track" -columns 3 -lines 10 -padding 20 -color-window "#330b0d13, #330b0d13, #000b0d13" -color-normal "#440b0d13, #e6e6e6, #440b0d13, #880b0d13, #e6e6e6")
			mpc search filename "$song" | mpc insert; mpc next; mpc -q play
			polybar-msg cmd show		
			break
			;;
		'ncmpcpp')
			termite -e 'ncmpcpp' &
			wal -q -R
			break
			;;
		' Volume')
			volume=$(mpc volume)
			mpc volume $(echo {1..100} | tr " " "\n" | rofi -dmenu -font "$font" -p $volume -columns 3 -lines 10 -padding 20 -color-window "#330b0d13, #330b0d13, #000b0d13" -color-normal "#440b0d13, #e6e6e6, #440b0d13, #880b0d13, #e6e6e6")
			break
			;;
		' Pause')mpc -q pause
			polybar-msg cmd hide
			break
			;;
		' Play')mpc -q play
			polybar-msg cmd show
			break
			;;
		' Select Song by Metadata')
			artist=$( mpc list artist | rofi -dmenu -font "$font" -p "Select Artist" -columns 3 -lines 10 -padding 20 -color-window "#330b0d13, #330b0d13, #000b0d13" -color-normal "#440b0d13, #e6e6e6, #440b0d13, #880b0d13, #e6e6e6")
			album=$(mpc list album artist "$artist" | rofi -dmenu -font "$font" -p "Select Album" -columns 3 -lines 10 -padding 20 -color-window "#330b0d13, #330b0d13, #000b0d13" -color-normal "#440b0d13, #e6e6e6, #440b0d13, #880b0d13, #e6e6e6")			    
			song=$(mpc list title artist "$artist" album "$album" | rofi -dmenu -font "$font" -p "Select Track" -columns 3 -lines 10 -padding 20 -color-window "#330b0d13, #330b0d13, #000b0d13" -color-normal "#440b0d13, #e6e6e6, #440b0d13, #880b0d13, #e6e6e6")

			mpc -q clear ; mpc search album "$album" artist "$artist" title "$song" | mpc add; mpc -q play	
			polybar-msg cmd show
			break
			;;
		' Next on Playlist')
			mpc -q next
			break
			;;
		' Previous on Playlist')
			mpc -q prev
			break
			;;
		' Add songs to playlist') 
			termite -e 'ncmpcpp -s media_library' &
			wal -q -R
			break
			;;
		' Visualizer')
			termite -e vis &
			wal -q -R
			break
			;;
	esac
	choice=$(echo -e $string |rofi -dmenu -font "$font" -p "MPD TOOLS" -columns 3 -lines 10 -padding 20 -color-window "#330b0d13, #330b0d13, #000b0d13" -color-normal "#440b0d13, #e6e6e6, #440b0d13, #880b0d13, #e6e6e6")
done
