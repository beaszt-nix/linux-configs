#! /bin/bash
unset used
unset unused
unset all
unset subnet
function selector(){
	if command -v rofi > /dev/null 2>&1;
	then
		rofi -dmenu -font "IBM Plex Sans SemiBold 18" -columns 3 -lines 10 -padding 20 -color-window "#330b0d13, #330b0d13, #000b0d13" -color-normal "#440b0d13, #e6e6e6, #440b0d13, #880b0d13, #e6e6e6" $*

		return 0
	elif command -v dmenu > /dev/null 2>&1;
	then
		dmenu "$1" "$2"
		return 0
	else
		echo "NEITHER ROFI NOR DMENU FOUND EXITTING"
		exit 1	
	fi
}

subnet=$(echo -e "64\n65" |selector -p "Select SubNet")

#HOUSEKEEPING TO AVOID WASTING TIME ON A NULL INPUT ARP

if [[ $subnet -gt 65 || $subnet -lt 64 ]];
then
	exit 1
fi

#ADD ARP-SCAN TO SUDOERS NOPASSWD FOR YOUR USER
#PIPE STDOUT OF ARP-SCAN THROUGH TEXT PROCESSING TO CREATE LIST OF INCREASING USED IP

used=$(sudo arp-scan -I enp3s0f3u1u2 192.168.$subnet.1-192.168.$subnet.254 | tail -n +3| head -n -3|awk '{print $1}'|cut -d . -f 4 | sort -n | uniq -u)
all=({1..254})

#PRINT BOTH USED IP AND ALL IP, PIPE THROUGH SED TO MAKE THEM DELIMITED BY NEWLINE
#SORT IN INCREASING ORDER, AND USE uniq -u TO REMOVE ALL DUPLICATES. ONLY UNUSED IP REMAIN.

unused=($(echo ${used[*]} ${all[*]} | sed 's/ /\n/g' | sort -n | uniq -u))

#IMPLODE THE ARRAY WITH UNUSED IP WITH NEWLINE AS DELIMITER AND PIPE THAT STDOUT INTO ROFI IN DMENU MODE

choice=$((IFS=$'\n'; echo "${unused[*]}") |selector -p "Select Open IP")

#EXIT SCRIPT IF NULL INPUT(ESCAPE)

if [$choice == ''];
then
	exit 1
fi

#SET PROFILE SETTINGS AND RELOAD THEM.

nmcli con mod "Profile 1" ipv4.addresses "192.168.$subnet.$choice/24" ipv4.gateway "192.168.$subnet.$choice"
nmcli con up "Profile 1"
notify-send -t 2400 "IPv4 updated to 192.168.$subnet.$choice"
