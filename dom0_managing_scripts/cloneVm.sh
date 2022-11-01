#!/bin/bash


ORIGIN_VM=Alpine		# VM to be cloned
CLONE_VM_NAME=alpineAuto	# New VM name

# Clonnig VM
qvm-clone $ORIGIN_VM $CLONE_VM_NAME

# Starting new Cloned VM
qvm-run $CLONE_VM_NAME

# Report Network Settings to be set.
qvm-ls -n $CLONE_VM_NAME

