#! /bin/bash

notify-send -t 2500 "Playing Video" "$(xclip -o)";
mpv $(xclip -o) --fs --af=rubberband=pitch-scale=0.981818181818181 --ytdl-format="bestvideo[height<=720]+bestaudio[abr<=320]"
