#!/bin/sh
echo "Last boot time: $(cat /proc/uptime)" > /etc/motd
