# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]];
then 
  startx
fi

# User specific environment and startup programs

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH=~/bin:$PATH
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$PATH:/home/anjan/.local/bin"

export TorrDBHostName="127.0.0.1:27018" 
export TorrentDB="torrentDB"
export TorrColl="torrents"
export TorrDBUserName="TorAdmin"
export TorrDBPassWord="SumProj2020"
export BROWSER="brave-browser"
export ANDROID_SDK=/home/anjan/Android/Sdk
export DOCKER_HOST='unix://var/run/docker.sock'
export MYSQL_ROOTPASS='makolo123'
