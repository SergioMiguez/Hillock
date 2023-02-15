# This custom kernel was developed for Alpine Linux to optimise bootup time in Qubes OS

WARNING!! RUN THIS IN AN EMPTY MACHINE FIRST

BACKUP EVERYTHING

RUN THIS AT YOUR OWN RISK!

IN CASE OF FAILURE YOUR MACHINE WONT BOOT

---

**Kernel version 5.15.91**

---

Run the kernel_install.sh script:

To run the scrip use the following command:
```su -c ./kernel_install.sh
su -c ./kernel_install.sh
```

Follow the instructions and make decisions using Y/Enter, n or input values.

##### In case you want to do the process yourself:

Download the tar of that kernel version in https://www.kernel.org
```wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.15.91.tar.xz
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.15.91.tar.xz
```

Unzip the file (you might need to install xz package)
```doas apk add xz
doas apk add xz
```

Install dependencies
```doas apk add alpine-sdk ncurses-dev bison flex bc perl libelf elfutils-dev openssl-dev findutils linux-headers pkgconfig installkernel
doas apk add alpine-sdk ncurses-dev bison flex bc perl libelf elfutils-dev openssl-dev findutils linux-headers pkgconfig installkernel
```

Make the kernel use the following commands:
```doas make -j 4 # 4=number of processing units used to compile
doas make -j 4 # 4=number of processing units used to compile
```
Other option is:
```doas make -j $(nproc) # gets number of available processing units automatically
doas make -j $(nproc) # gets number of available processing units automatically
```

Install the kernel
```Install the kernel
doas make modules_install
doas make install
Update bootloader (required to finish installation)
```
Remove default syslinux
```doas apk del syslinux
doas apk del syslinux
```
Install grub
```Install grub
doas apk add grub grub-bios
doas grub-install /dev/sda # check fdisk -l just in case
grub-mkconfig -o /boot/grub/grub.cfg
```
if you want to make changes in grub: `vi /etc/grub.d/40_custom`

add: `GRUB_TIMEOUT=0 # to skip the waiting`

Then rung grub-mkconfig command again

To finish installation reboot your machine
```To finish installation reboot your machine
doas reboot
```
