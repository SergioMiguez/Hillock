This custom kernel was developed for Alpine Linux to optimise bootup time in Qubes OS
Kernel version 5.15.91

For future use:
	Download the tar of that kernel version in https://www.kernel.org
	unzip
	need to install dependencies alpine-sdk, xz, ncurses-dev, bison, flex,
		bc, perl, libelf-dev (not found?), openssl-dev, findutils, linux-headers, findutils
		pkjconfig-dev (review) and others
	apk add installkernel

	Then to make the kernel use the following commands:
		
		make -j 4 (4=number of cores used to compile)
			other option is: make -j $(nproc) # gets threads or cpu cores automaticaly
		doas make modules_install
		doas make install

	update bootloader
		remove default syslinux
			apk del syslinux
		install grub & grub-bios
		grub-install /dev/sda (check fdisk -l in case)
		grub-mkconfig -o /boot/grub/grub.cfg 
			if you want to make changes in grub 
				vi /etc/grub.d/40_custom 
					add: GRUB_TIMEOUT=0 (to skip the waiting)
			then rung grub-mkconfig command again

	doas reboot
	
	
