# WARNING!! RUN THIS IN AN EMPTY MACHINE FIRST
# BACKUP EVERYTHING 
# RUN THIS ON YOUR OWN RISK!
# IN CASE OF FAILURE YOUR MACHINE WONT BOOT

# SERGIO MIGUEZ APARICIO 2023 - University of Edinburgh


#!/bin/bash 
# replace with kernel version, the custom build is for that version
# changing the version is made on your own risk!! (it might not work)
KERNEL_VERSION=linux-5.15.91
# replace where the boot system is
DISK=/dev/sda

#echo Getting Updates
#doas apk update 
#doas apk upgrade


echo Installing packages
doas apk add alpine-sdk 
doas apk add xz
doas apk add ncurses-dev
doas apk add bison
doas apk add flex
doas apk add bc
doas apk add perl
doas apk add libelf
doas apk add elfutils-dev
doas apk add openssl-dev
doas apk add findutils
doas apk add linux-headers
doas apk add pkgconfig
doas apk add installkernel

echo Getting kernel= $KERNEL_VERSION
REPOSITORY=$(pwd)
cd 
doas wget https://cdn.kernel.org/pub/linux/kernel/v5.x/$KERNEL_VERSION.tar.xz
tar -xvf $KERNEL_VERSION.tar.xz
cd $KERNEL_VERSION
doas make clean
doas make defconfig

# Important, kernel only for x86 and only 64-bit systems with no 32-bit compatibility
echo replacing .config file
doas cp -fr $REPOSITORY/.config .

echo MAKING
doas make -j $(nproc)

echo MAKE modules_install
doas make modules_install -j $(nproc)

echo MAKE install
doas make install -j $(nproc)


: '
echo Updating bootloader
doas apk del syslinux
doas apk add grub 
doas apk add grub-bios
grub-install $DISK
echo -e "GRUB_TIMEOUT=0" >> /etc/grub.d/40_custom
doas grub-mkconfig -o /boot/grub/grub.cfg
doas reboot
'
echo DONE