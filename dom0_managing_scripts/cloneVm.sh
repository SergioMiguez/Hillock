########################
# Cloning VM Script
########################


#!/bin/bash

source_vm=Alpine
clone_vm_name=alpineAuto

# Clonnig VM
qvm-clone $source_vm $clone_vm_name

# Starting new Cloned VM
qvm-run $clone_vm_name

# Report Network Settings to be set.
qvm-ls -n $clone_vm_name

