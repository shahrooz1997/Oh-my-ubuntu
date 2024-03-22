#!/bin/bash

sudo ls > /dev/null

set -e

# Install Apps
sudo apt-get update
sudo apt-get install -y git tig wget curl unrar unzip vim build-essential vlc python3 ansible gnome-tweaks gparted proxychains uget python3-pip apt-transport-https ca-certificates software-properties-common pinta file gnome-tweaks gcc-12
git config --global user.name "Hamidreza Zare"
git config --global user.email "shahrooz.1000@gmail.com"
sudo update-alternatives --set editor $(which vim.basic)

# Install sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# Save current path
cur_path=`pwd`

# Install VirtualBox only if the host is on a bare machine
sudo apt-get install -y virt-what
is_virtual=$(sudo virt-what)
if [ -z $is_virtual ]; then
	# Install VirtualBox
	cd /tmp
	wget https://download.virtualbox.org/virtualbox/7.0.14/virtualbox-7.0_7.0.14-161095~Ubuntu~jammy_amd64.deb
	sudo apt install -y /tmp/virtualbox-7.0_7.0.14-161095~Ubuntu~jammy_amd64.deb

	# Download VirtualBox Guest Additions
	cd ~/Downloads/
	wget https://download.virtualbox.org/virtualbox/7.0.14/VBoxGuestAdditions_7.0.14.iso

	# Download Ubuntu 22 iso
	cd ~/Downloads/
	wget https://releases.ubuntu.com/22.04/ubuntu-22.04.4-desktop-amd64.iso
else
	# Download VirtualBox Guest Additions
	cd /tmp
	wget https://download.virtualbox.org/virtualbox/6.1.32/VBoxGuestAdditions_6.1.32.iso
	sudo mkdir /tmp/VBoxGuestAdditions_6.1.32_mount_point
	sudo mount VBoxGuestAdditions_6.1.32.iso /tmp/VBoxGuestAdditions_6.1.32_mount_point
	cd VBoxGuestAdditions_6.1.32_mount_point/
	sudo ./autorun.sh
fi
sudo apt-get purge -y virt-what

# Install Oh-My-Zsh
sudo apt install -y zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --skip-chsh < /dev/null
sudo chsh -s $(which zsh) $(whoami)

# Installing Telegram
sudo snap install telegram-desktop
telegram-desktop &

# Install fonts
cd $cur_path
mkdir fonts
cd fonts/
unzip ../Source_Code_Pro.zip
mkdir -p "/home/$USER/.local/share/fonts/"
cp ./* "/home/$USER/.local/share/fonts/"
cd ..
rm -rf fonts

dconf load /org/gnome/terminal/legacy/profiles:/:980d4086-76bd-4989-9655-6f5330e4c5b5/ < shahrooz-theme-profile.dconf
curList=`gsettings get org.gnome.Terminal.ProfilesList list`
strLen=${#curList}
p=`echo "$strLen - 1" | bc`
curList="${curList:0:$p},'980d4086-76bd-4989-9655-6f5330e4c5b5']"
echo $curList
gsettings set org.gnome.Terminal.ProfilesList list $curList
gsettings set org.gnome.Terminal.ProfilesList default '980d4086-76bd-4989-9655-6f5330e4c5b5'

if [ -f ssh.tar.gz ]; then
	cd
	tar -xzf $cur_path/ssh.tar.gz
	cd $cur_path
fi

cd /tmp
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-468.0.0-linux-x86_64.tar.gz
tar -xzf google-cloud-cli-468.0.0-linux-x86_64.tar.gz
sudo mv google-cloud-sdk /opt/
cd /opt
./google-cloud-sdk/install.sh -q --rc-path /home/$USER/.zshrc


gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.screensaver lock-enabled false
backgroundURI=${cur_path}/background.png
gsettings set org.gnome.desktop.background picture-uri ${backgroundURI}
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings set org.gnome.desktop.background picture-options 'scaled'
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,close'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface font-name 'Ubuntu 14'
gsettings set org.gnome.desktop.interface document-font-name 'Source Code Pro 15'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu 15'

sudo snap install --classic code
sudo snap install --classic intellij-idea-ultimate
sudo snap install --classic clion
sudo snap install --classic pycharm-professional
sudo snap install --classic datagrip
sudo snap install --classic webstorm
