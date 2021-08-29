disk=$(lsblk -ro NAME,TYPE,SIZE | grep -v -e "disk" -e "^nvme0n1" | awk 'NR > 1 {printf "%-10s \t\t\t %5s\n", $1,$3}' | rofi -dmenu -p "Enter the utility name" -fullscreen -font "IBM Plex Sans SemiBold 16" -columns 3 -lines 10 -padding 20 -color-window "#330b0d13, #330b0d13, #000b0d13" -color-normal "#440b0d13, #e6e6e6, #440b0d13, #880b0d13, #e6e6e6" | awk '{print $1}')

echo $disk
