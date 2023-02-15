# Testing Boot Up Time of Kernel

To measure the boot up time, place timer.sh in the /root folder and update the crond config file using:

```bash
crondtab -e
```

Inside add the command from crond.sh: `@reboot sh /root/timer.sh`

The path mush be changed to the path to where you placed the timer.sh file.

The "@reboot" command could not work, it depends on the crond version.


To make proper readings, it is required that the system autologsin:

```bash
apk add util-linux
```

Then edit the file /etc/inittab, comment line 8 "tty1::respawn:/sbin/getty 38400 tty1" and add the following line below:

```bash
tty1::respawn:/sbin/agetty --skip-login --nonewline --autologin $USER --noclear 38400 tty1
```

Replace $USER with your user, in my case 'root'. No password required.
