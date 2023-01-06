#!/bin/bash

##### Please note this script is still under development
##### Внимание! Скрипт в стадии разработки и тестирования

SOURCES="https://github.com/evgs/fb_st7796s.git"

die() { echo "$*" 1>&2 ; exit 1; }

echo "Check kernel architecture..."
uname -a | grep sun50iw6 || die "Unknown kernel architecture"

#sudo apt update
#sudo apt install git build-essential linux-headers-current-sunxi64

cd ~
rm -rf fb_st7796s

echo "Fetching sources..."
git clone $SOURCES
cd ~/fb_st7796s/kernel_module/

echo "Building driver..."
make

echo "Installing kernel module..."
sudo make install
make clean
sudo depmod -A

echo "Appending to initramfs..."

grep -qxF 'fb_st7796s' /etc/initramfs-tools/modules || echo fb_st7796s | sudo tee /etc/initramfs-tools/modules
sudo update-initramfs -u

echo "Installing overlay..."
sudo orangepi-add-overlay ~/fb_st7796s/dts/sun50i-h6-st7796s.dts

echo "Copying xorg.conf rules..."
sudo cp ~/fb_st7796s/xorg.conf.d/50* /etc/X11/xorg.conf.d
sudo cp ~/fb_st7796s/xorg.conf.d/51* /etc/X11/xorg.conf.d

echo "Your need reboot your SBC to activate module"
