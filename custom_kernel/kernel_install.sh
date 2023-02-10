# WARNING!! RUN THIS IN AN EMPTY MACHINE FIRST
# BACKUP EVERYTHING 
# RUN THIS AT YOUR OWN RISK!
# IN CASE OF FAILURE YOUR MACHINE WONT BOOT

# SERGIO MIGUEZ APARICIO 2023 - University of Edinburgh

# TO RUN THE SCRIPT USE: 
#       su -c ./kernel_install.sh
# AND FOLLOW THE INSTRUCTIONS

#!/bin/bash 
# replace with kernel version, the custom build is for that version
# changing the version is made on your own risk!! (it might not work)

KERNEL_VERSION=linux-5.15.91
echo Your Current Kernel version is $(uname -r)

read -p 'Select new Kernel: [Y='"$KERNEL_VERSION"', or type kernel version] ' USER_KERNEL
if [[ "$USER_KERNEL" != "Y" && "$USER_KERNEL" != "" ]]; then
	KERNEL_VERSION=$USER_KERNEL
fi

echo Installing Base Kernel: $KERNEL_VERSION

# replace where the boot system is
DISK=/dev/sda
echo Printing Disk Partitions:
fdisk -l
read -p 'Select disk with boot: [Y='"$DISK"', or type disk] ' USER_DISK
if [[ "$USER_DISK" != "Y" && "$USER_DISK" != "" ]]; then
	DISK=$USER_DISK
fi

echo Selected Disk: $DISK 
read -p 'Install required packages? [Y/n] ' USER_PKG
if [[ "$USER_PKG" = "Y" || "$USER_PKG" = "" ]]; then
	echo Installing packages
	apk add alpine-sdk 
	apk add xz
	apk add ncurses-dev
	apk add bison
	apk add flex
	apk add bc
	apk add perl
	apk add libelf
	apk add elfutils-dev
	apk add openssl-dev
	apk add findutils
	apk add linux-headers
	apk add pkgconfig
	apk add installkernel
else
	echo Skipped packages install
fi

REPOSITORY=$(pwd)
cd

read -p 'Download kernel (to path ~/) [Y/n]: ' USER_DWN
if [[ "$USER_DWN" = "Y" || "$USER_DWN" = "" ]]; then
	echo Getting kernel= $KERNEL_VERSION 
	wget https://cdn.kernel.org/pub/linux/kernel/v5.x/$KERNEL_VERSION.tar.xz
	tar -xvf $KERNEL_VERSION.tar.xz
fi

read -p 'Decompres Kernel: [Y/n] ' USER_DECOMPRESS
if [[ "$USER_MK" = "Y" || "$USER_MK" = "" ]]; then
	cd $KERNEL_VERSION
	make clean
	make defconfig
fi

read -p 'Compile Kernel: [Y/n] ' USER_MK
if [[ "$USER_MK" = "Y" || "$USER_MK" = "" ]]; then
	cd $KERNEL_VERSION
	# Important, kernel only for x86 and only 64-bit systems with no 32-bit compatibility
	echo replacing .config file
	cp -fr $REPOSITORY/.config .
	
	read -p 'Number of processing units to use? [Y=nproc/input number] ' USER_THREADS
	if [[ "$USER_THREADS" = "Y" || "$USER_THREADS" = "" ]]; then
		USER_THREADS=$(nproc)
	fi
	echo MAKING Using $USER_THREADS processing units
	make -j $USER_THREADS
fi

read -p 'Install Kernel? [Y/n] ' USER_INSTALL
if [[ "$USER_INSTALL" = "Y" || "$USER_INSTALL" = "" ]]; then 
	cd $KERNEL_VERSION
	echo MAKE modules_install
	read -p 'Number of processing units to use? [Y=nproc/input number] ' USER_THREADS_
	if [[ "$USER_THREADS_" = "Y" || "$USER_THREADS_" = "" ]]; then
        	USER_THREADS=$(nproc)
	fi
	echo Using $USER_THREADS_ processing units
	make modules_install -j $USER_THREADS_

	echo MAKE install
	make install -j $USER_THREADS
fi

read -p 'Update Bootloader? [Y/n] (required to end install) ' USER_BOOT
if [[ "$USER_ROOT" = "Y" || "$USER_BOOT" = "" ]]; then
	echo Updating bootloader
	apk del syslinux
	apk add grub 
	apk add grub-bios
	grub-install $DISK

	read -p 'Skip Grub Timeout? [Y/n]' USER_SKIP

	if [[ "$USER_SKIP" = "Y" || "$USER_SKIP" = "" ]]; then
		echo -e "GRUB_TIMEOUT=0" >> /etc/grub.d/40_custom
	fi

	grub-mkconfig -o /boot/grub/grub.cfg
fi 

read -p 'Clean/delete install files? [Y/n] ' USER_DEL
if [[ "$USER_DEL" = "Y" || "$USER_DEL" = "" ]]; then
	cd 
	rm -r $KERNEL_VERSION $KERNEL_VERSION.tar.xz
fi

read -p 'Reboot? [Y/n] ' USER_REBOOT
if [[ "$USER_REBOOT" = "Y" || "$USER_REBOOT" = "" ]]; then
	reboot
fi
echo DONE

