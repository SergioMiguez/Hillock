########################
# ELIMINATING VM SCRIPT
########################


#!/bin/bash

vm_name=alpineAuto	# Machine Name to be removed

# Removing VM: [--force] is used to prevent y/N confirmation
qvm-remove --force $vm_name

# Checking that the VM does not exist -> Error to find VM should be reported
virsh -c xen:/// dominfo $vm_name

echo "DONE"

