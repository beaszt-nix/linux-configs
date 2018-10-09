#!/bin/bash -x

#Lots of comments for a simple string of commands, eh?

#VARIABLES: for adding more folders easily in the future
CONFIG=/home/anjan/.config
HOME=/home/anjan
DATE=$(date +'%Y-%m-%d')
BACKUP=/home/anjan/backup
cd $HOME && mkdir backup
rm -rf $HOME/git/backup.tar.xz

#COPY BLOCK: copies all the selected folders to a temporary folder. "-r" option is for recursive directory
#            copying
cp -r $CONFIG/i3 $BACKUP
cp -r $CONFIG/neofetch $BACKUP
cp -r $CONFIG/polybar $BACKUP
cp -r $CONFIG/ranger $BACKUP
cp -r $CONFIG/termite $BACKUP
cp -r $HOME/script.sh $BACKUP     #function in shell that selects randon wallpaper and runs through feh and pywal.
                                  #systemd timer and service units for this are in .config/personal folder of backup tarball
cp -r $HOME/flash_win.sh $BACKUP  #script to use with i3 for indicating window in use. 
cp -r $HOME/backup.sh $BACKUP     #this script. THIS (WHAT YOUR ARE READING) SCRIPT

#COMPRESSION: MAKES A COMPRESSED TARBALL OF THE CONFIGS IN TEMPORARY FOLDER
tar -cJf $HOME/backup.$DATE.tar.xz $HOME/backup

#CLEANUP and RELOCATION
rm -rf $HOME/backup
mv $HOME/backup.$DATE.tar.xz $HOME/Documents/backup.$DATE.tar.xz 

#COMPRESSION_STAGE_TWO: Compresses git projects that are cloned for non-repo packages into tarball
##NOTE:"lbzip2 is the best parallel implimentation of the respective compression formats. pigz is inefficient and 
##      both the XZ formats are very memory hungry and slow(comparatively; not as much as the single threaded process),
##      in exchange provide a size profit of about 75mb per gig.
##      Maybe try pbzip2"
tar -I "lbzip2 -9" -cf $HOME/Documents/git_files.tar.bz2 $HOME/git 
printf "DONE"
