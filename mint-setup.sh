#!/bin/bash

# mint-setup.sh
# 
# The purpose of this script is to call other github/chaslinux scripts we use to deploy a user-friendly
# version of Linux Mint, complete with extra software we think will be handy to end users, as well as
# a script to detect the system's hardware, and run a couple of benchmarks: geekbench6, and yaquake2.
#
# NOTE: do not run this script with sudo, but you should be a user with sudo access, it will prompt you
# for your password in order to install software.
# 
# In other words, just enter the directory this file is in and type: ./mint-setup.sh
#
# by chaslinux@gmail.com
# Licensed under GPL v3

GINSTALL=$(which git)


## first run all updates
sudo apt update && sudo apt upgrade -y && flatpak update -y

# Check if git is installed, if not, install git
if [ -z "$GINSTALL" ];
    then
        echo "*** Installing git ***"
        sudo apt install git -y
fi

# make the code directory and change into it
mkdir ~/Code
cd ~/Code

# clone the git repositories we use
git clone https://github.com/chaslinux/hardware.sh
git clone https://github.com/chaslinux/mint-extras
# No need to do geekbench anymore using sysbench and glmark2 in hardware.sh to do benchmarking
# git clone https://github.com/chaslinux/geekbench-dl
git clone https://github.com/chaslinux/mint-device-screensaver
git clone https://github.com/chaslinux/update-firmware


# now run the hardware detection script, followed by the mint-extras (additional software), and
# then the CPU benchmark geekbench
cd ~/Code/hardware.sh
./hardware.sh
cd ~/Code/mint-extras
./mint-extras.sh

# Install mint-device-screensaver, not a screensaver as such, but a display
cd ~/Code/mint-device-screensaver
./install.sh

# Now check for firmware updates
cd ~/Code/update-firmware
./update-firmware.sh

