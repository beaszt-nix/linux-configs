#!/bin/bash

# Natively, explicitly installed packages
pacman -Qqne > pkg_list.arch
# AUR explicitly installed packages
pacman -Qqme > pkg_list.aur

git add .
git commit -m "Version: $(date)"
git push
