#!/bin/bash

sudo apt-get update
sudo apt-get install qemu
sudo apt-get install qemu-kvm
sudo apt-get install qemu-system-arm

sudo apt-get install git
sudo apt-get install vim
sudo apt-get install bridge-utils

git clone --depth=1 https://github.com/raspberrypi/tools.git
export PATH="/home/mada/an4/si/tools/arm-bcm2708/arm-linux-gnueabihf/bin/:$PATH"
