#########################
# CREATE HVM STANDALONE VM 
#	Assume iso of Alpine in {untrusted} qube at "/home/user/Downloads/" 
#########################


#!/bin/bash

vm_type=StandaloneVM	# Type of VM
name=alpineAuto 	# Name of new VM
color=green		# GUI label color
vm_mode=hvm		# Hardware Virtual Machine
init_ram=190		# Initial given RAM to the VM in MB

# Creating VM
qvm-create -v --class $vm_type --label $color --property virt_mode=$vm_mode $name

# Setting VM preferentces
# RAM configuration
qvm-prefs $name memory $init_ram
qvm-prefs $name maxmem $init_ram
# Kernel configuration
qvm-prefs $name kernel ''

# Starting VM using Alpine ISO located at the Untrusted Qube
qvm-start -v --cdrom=untrusted:/home/user/Downloads/alpine.iso $name

# Reporting VM Creation and Configuration
virsh -c xen:/// dominfo $name
# Reporting VM Network Configuration (IP and Gateway) to be manually set later in Network Congiguration inside VM
qvm-ls -n $name

echo "DONE"

