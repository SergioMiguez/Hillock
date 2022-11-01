#!/bin/bash

TYPE=StandaloneVM	# Type of VM
NAME=alpineAuto 	# Name of new VM
COLOR=green		# GUI label color
VMODE=hvm		# Hardware Virtual Machine
INIT_RAM=190		# Initial given RAM to the VM in MB
#RAM=160 		# After installation RAM in MB

# Creating VM
qvm-create -v --class $TYPE --label $COLOR --property virt_mode=$VMODE $NAME

# Setting VM preferentces
# RAM configuration
qvm-prefs $NAME memory $INIT_RAM
qvm-prefs $NAME maxmem $INIT_RAM
# Kernel configuration
qvm-prefs $NAME kernel ''

# Starting VM using Alpine ISO located at the Untrusted Qube
qvm-start -v --cdrom=untrusted:/home/user/Downloads/alpine.iso $NAME

# Reporting VM Creation and Configuration
virsh -c xen:/// dominfo $NAME 
# Reporting VM Network Configuration (IP and Gateway) to be manually set later in Network Congiguration inside VM
qvm-ls -n $NAME

