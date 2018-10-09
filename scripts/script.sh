#!/usr/bin/zsh
wal-tile() {
    wal -a 0.75 -n -i "$@"
    feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
}
wal-tile $(find /home/anjan/wallpaper/ -type f | shuf -n 1)
