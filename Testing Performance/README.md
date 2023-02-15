To measure the boot up time, place timer.sh in the /root folder and update the crond config file using:

```Crond
crondtab -e
```

Inside add the command from crond.sh: `@reboot sh /root/timer.sh`

The path mush be changed to the path to where you placed the timer.sh file.

The "@reboot" command could not work, it depends on the crond version.
