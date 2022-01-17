#!/bin/bash

sudo ls > /dev/null

set -e

# Install Apps
sudo apt-get install -y git tig wget curl unrar unzip vim vlc python python3 ansible gnome-tweaks gparted python-virtualenv proxychains uget python3-pip python-pip apt-transport-https ca-certificates curl software-properties-common
git config --global user.name "Hamidreza Zare"
git config --global user.email "shahrooz.1000@gmail.com"
sudo update-alternatives --set editor $(which vim.basic)

# Install sublime
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
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
	wget https://download.virtualbox.org/virtualbox/6.1.26/virtualbox-6.1_6.1.26-145957~Ubuntu~bionic_amd64.deb
	sudo apt-get install -y build-essential libcurl4 libqt5core5a libqt5gui5 libqt5opengl5 libqt5printsupport5 libqt5widgets5 libqt5x11extras5 libsdl1.2debian
	sudo dpkg -i virtualbox-6.1_6.1.26-145957~Ubuntu~bionic_amd64.deb

	# Download VirtualBox Guest Additions
	cd ~/Downloads/
	wget https://download.virtualbox.org/virtualbox/6.1.26/VBoxGuestAdditions_6.1.26.iso

	# Download Ubuntu 18 iso
	cd ~/Downloads/
	wget https://releases.ubuntu.com/18.04/ubuntu-18.04.6-desktop-amd64.iso
	if [ $(sha256sum ubuntu-18.04.6-desktop-amd64.iso) != "f730be589aa1ba923ebe6eca573fa66d09ba14c4c104da2c329df652d42aff11" ]; then
		echo "Download of https://releases.ubuntu.com/18.04/ubuntu-18.04.6-desktop-amd64.iso was unsuccessful"
		exit 1
	fi
fi
sudo apt-get purge -y virt-what

# Install Oh-My-Zsh
sudo apt install -y zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --skip-chsh < /dev/null
sudo chsh -s $(which zsh) $(whoami)

# Installing Telegram
cd /tmp
wget https://updates.tdesktop.com/tlinux/tsetup.3.0.1.tar.xz
tar -xvf tsetup.3.0.1.tar.xz
sudo mv Telegram /opt/
cd
/opt/Telegram/Telegram &

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
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-357.0.0-linux-x86_64.tar.gz
tar -xzf google-cloud-sdk-357.0.0-linux-x86_64.tar.gz
sudo mv google-cloud-sdk /opt/
cd /opt
./google-cloud-sdk/install.sh -q --rc-path /home/test/.zshrc


gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.screensaver lock-enabled false
backgroundURI=${cur_path}/background.png
gsettings set org.gnome.desktop.background picture-uri ${backgroundURI}
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings set org.gnome.desktop.background picture-options 'scaled'
gsettings set org.gnome.nautilus.desktop volumes-visible false
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,close'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface font-name 'Ubuntu 14'
gsettings set org.gnome.desktop.interface document-font-name 'Source Code Pro 15'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu 15'

cd /tmp
wget https://download-cdn.jetbrains.com/cpp/CLion-2021.2.2.tar.gz
tar -xzf CLion-2021.2.2.tar.gz
sudo mv clion-2021.2.2 /opt/
cd /opt/clion-2021.2.2/bin
./clion.sh &
sudo ln -s /opt/clion-2021.2.2/bin/clion.sh /usr/local/bin/clion
sudo bash -c 'printf "[Desktop Entry]
Name=CLion
Exec=/opt/clion-2021.2.2/bin/clion.sh
Icon=/opt/clion-2021.2.2/bin/clion.png
Terminal=false
Type=Application
Encoding=UTF-8
Categories=Application;
Name[en_US]=CLion\n" > /usr/share/applications/CLion.desktop'

cd /tmp
wget https://download-cdn.jetbrains.com/python/pycharm-professional-2021.2.2.tar.gz
tar -xzf pycharm-professional-2021.2.2.tar.gz
sudo mv pycharm-2021.2.2 /opt/
sudo ln -s /opt/pycharm-2021.2.2/bin/pycharm.sh /usr/local/bin/pycharm
sudo bash -c 'printf "[Desktop Entry]
Name=PyCharm
Exec=/opt/pycharm-2021.2.2/bin/pycharm.sh
Icon=/opt/pycharm-2021.2.2/bin/pycharm.png
Terminal=false
Type=Application
Encoding=UTF-8
Categories=Application;
Name[en_US]=PyCharm\n" > /usr/share/applications/PyCharm.desktop'

cd /tmp
wget https://download-cdn.jetbrains.com/idea/ideaIU-2021.2.2.tar.gz
tar -xzf ideaIU-2021.2.2.tar.gz
sudo mv idea-IU-212.5284.40 /opt/
sudo ln -s /opt/idea-IU-212.5284.40/bin/idea.sh /usr/local/bin/idea
sudo bash -c 'printf "[Desktop Entry]
Name=Idea
Exec=/opt/idea-IU-212.5284.40/bin/idea.sh
Icon=/opt/idea-IU-212.5284.40/bin/idea.png
Terminal=false
Type=Application
Encoding=UTF-8
Categories=Application;
Name[en_US]=Idea\n" > /usr/share/applications/Idea.desktop'

# Install VS Code
cd /tmp
wget https://az764295.vo.msecnd.net/stable/83bd43bc519d15e50c4272c6cf5c1479df196a4d/code_1.60.1-1631294805_amd64.deb
sudo dpkg -i code_1.60.1-1631294805_amd64.deb


