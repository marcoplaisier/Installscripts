#!/bin/bash
clear
echo "Removing libre office"
apt-get --purge remove libreoffice

echo "Updating an upgrading the OS"
apt-get update -y
apt-get upgrade -y

echo "Installing essential packages for the daemon"
apt-get install build-essential pkg-config libusb-1.0-0-dev libudev-dev pm-utils -y

echo "Installing Brick daemon"
wget http://download.tinkerforge.com/tools/brickd/linux/brickd_linux_latest_armhf.deb
dpkg -i brickd_linux_latest_armhf.deb

echo "Installing Brick deamon Python (2 and 3) bindings"
pip3 install tinkerforge
pip install tinkerforge

echo "Removing installation files"
rm -f brickd_linux_latest_armhf.deb

echo "Installation complete"
echo
