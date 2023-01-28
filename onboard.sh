#!/bin/bash

# main.command

#  Created by _yourname_

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/main/install.sh)"

# Install necessary tools
if [ ! -d "/Applications/Microsoft Teams.app" ]; then
	brew install --cask microsoft-teams
else
	echo "Teams already installed"
fi	

if [ ! -d "/Applications/Docker.app" ]; then
	brew install --cask docker
else
	echo "Docker Desktop already installed"
fi

sudo open -a docker
osascript -e 'tell application "Docker" to set visible of front window to false'

if [ ! -d "/Applications/TablePlus.app" ]; then
	brew install --cask tableplus 
else
	echo "TablePlus already installed"
fi	

brew install git
brew install node

if [ ! -d "/Applications/GitHub Desktop.app" ]; then
	brew install --cask github-desktop 
else
	echo "GitHub Desktop already installed"
fi	

if [ ! -d "/Applications/PhpStorm.app" ]; then
	brew install --cask phpstorm 
else
	echo "PHPStorm already installed"
fi

if [ ! -d "/Applications/Visual Studio Code.app" ]; then
	brew install --cask visual-studio-code
else
	echo "VSCode already installed"
fi

while true; do

read -p "Please confirm when you have added your SSH key to GitHub type y : " yn

case $yn in
	[yY] ) echo "Ok cool, proceeding!"
			break;;
	[nN] ) echo "You need to do that first"
			exit;;
			* ) echo invalid response;;
esac

done

echo "Setting up repo's"

if [ ! -d "$HOME/code" ]; then
    mkdir ~/code
fi

if [ -d "$HOME/code/seg-dev-env" ]; then
    rm -rf ~/code/seg-dev-env
fi

cd ~/code && git clone git@github.com:lucidux/seg-dev-env.git && cd ~/code/seg-dev-env && ./init.sh

if grep -Fx "127.0.0.1 api.seg.devel portal.seg.devel signup.seg.devel" /etc/hosts
then
	echo "Host entries are good"
else
	echo "Updating hosts file"
	sudo bash -c 'echo -e "--ADDED BY ONBOARDING SCRIPT---\n127.0.0.1 api.seg.devel portal.seg.devel signup.seg.devel\n--END---" >> /etc/hosts'
fi

echo "******* DEV ENVIRONMENT READY! **********"
echo "https://api.seg.devel"
echo "https://portal.seg.devel"
echo "https://signup.seg.devel"
echo "now available.."
echo "*****************************************"

exit 0
