This custom kernel was developed for Alpine Linux to optimise bootup time in Qubes OS
Kernel version 5.15.91


Download the tar of that kernel version in https://www.kernel.org 
	wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.15.91.tar.xz
Unzip the file (you might need to install xz package)
	doas apk add xz
Install dependencies
	doas apk add alpine-sdk ncurses-dev bison flex bc perl libelf-dev openssl-dev findutils linux-headers findutils pkfconfig-dev installkernel
libelf might not be found, use libelf 

Make the kernel use the following commands:
	doas make -j 4 #(4=number of cores used to compile)
Other option is: 
	doas make -j $(nproc) # gets threads or cpu cores automaticaly
	doas make modules_install
	doas make install

Update bootloader
-> Remove default syslinux
	doas apk del syslinux
	doas apk add grub grub-bios
	doas grub-install /dev/sda #(check fdisk -l in case)
	grub-mkconfig -o /boot/grub/grub.cfg 
if you want to make changes in grub 
	vi /etc/grub.d/40_custom 
add: 
	GRUB_TIMEOUT=0 (to skip the waiting)
Then rung grub-mkconfig command again

Reboot
	doas reboot
	
	
