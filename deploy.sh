!# /bin/bash

read -s -p "Enter Password for sudo: " sudoPW
echo $sudoPW | sudo -S pacman --noconfirm -Syu
echo $sudoPW | sudo -S pacman --noconfirm -S - < ./pkg_list.arch

mkdir temp && cd temp
git clone https://aur.archlinux.com/yay.git && cd yay
echo $sudoPW | sudo -S ls >> /dev/null
makepkg -Acsi --noconfirm

cd ./../../
rm -rf ./temp

echo $sudoPW | sudo -S fc-cache -fv
yay -S --sudoloop $(cat ./pkg_list.aur)
cd ./dotfiles
stow $(ls)
