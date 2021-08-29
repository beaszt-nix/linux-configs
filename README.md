# Arch-Linux Configs
To setup GUI once bootable CLI installed.

## To Install
```
chmod +x deploy.sh
./deploy.sh
```

## Provisions
1. Stores all configurations using symlinks, source files can be found in dotfiles directory.
2. Enables systemd service unit to run daily, will update packages list in repo and push new commit if necessary.
3. Pre-Installs yay as default AUR helper
4. Auto-setup for MPD and NCMPCPP, along with helper scripts located at dotfiles/scripts/mpd\_sh.sh
5. i3-wm with Gaps, and picom-ibhagwan fork for terminal blur installed.
6. alEdit.sh, containing bash functions to dynamically add and remove bash aliases located in dotfiles/bash
7. All other convenience scripts are located at `dotfiles/scripts/.config/scripts`
