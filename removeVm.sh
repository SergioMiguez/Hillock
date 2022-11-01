#!/bin/bash


VM_NAME=alpineAuto	# Machine Name to be removed

# Removing VM, --force is used to prevent y/N confirmation
qvm-remove --force $VM_NAME 

# Checking that the VM does not exist -> Error to find VM should be reported
virsh -c xen:/// dominfo $VM_NAME
