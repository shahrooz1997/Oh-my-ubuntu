#!/bin/bash

sudo ls > /dev/null

# Install Apps
sudo apt-get install -y git tig wget curl unrar unzip vim vlc python python3 ansible gnome-tweaks
git config --global user.name "Hamidreza Zare"
git config --global user.email "shahrooz.1000@gmail.com"

# Install sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install -y apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# Save current path
cur_path=`pwd`

# Install VirtualBox
cd /tmp
wget https://download.virtualbox.org/virtualbox/6.1.26/virtualbox-6.1_6.1.26-145957~Ubuntu~bionic_amd64.deb
sudo apt-get install -y build-essential libcurl4 libqt5core5a libqt5gui5 libqt5opengl5 libqt5printsupport5 libqt5widgets5 libqt5x11extras5 libsdl1.2debian
sudo dpkg -i virtualbox-6.1_6.1.26-145957~Ubuntu~bionic_amd64.deb

# Download Ubuntu 18 iso
cd ~/Downloads/
wget https://old-releases.ubuntu.com/releases/18.04.5/ubuntu-18.04-desktop-amd64.iso

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

cd
tar -xzf $cur_path/ssh.tar.gz
cd $cur_path

cd /tmp
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-357.0.0-linux-x86_64.tar.gz
tar -xzf google-cloud-sdk-357.0.0-linux-x86_64.tar.gz
sudo mv google-cloud-sdk /opt/
cd /opt
./google-cloud-sdk/install.sh -q --rc-path /home/test/.zshrc


gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.screensaver lock-enabled false
backgroundURI=${cur_path}/background.jpg
gsettings set org.gnome.desktop.background picture-uri ${backgroundURI}
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings set org.gnome.desktop.background picture-options 'centered'
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
cd /tmp
wget https://download-cdn.jetbrains.com/python/pycharm-professional-2021.2.2.tar.gz
tar -xzf pycharm-professional-2021.2.2.tar.gz
sudo mv pycharm-2021.2.2 /opt/
cd /tmp
wget https://download-cdn.jetbrains.com/idea/ideaIU-2021.2.2.tar.gz
tar -xzf ideaIU-2021.2.2.tar.gz
sudo mv idea-IU-212.5284.40 /opt/

# Install VS Code
cd /tmp
wget https://az764295.vo.msecnd.net/stable/83bd43bc519d15e50c4272c6cf5c1479df196a4d/code_1.60.1-1631294805_amd64.deb
sudo dpkg -i code_1.60.1-1631294805_amd64.deb
