#########################
# UPDATING REPO
# 	Send files from Dom0 to working qube to update the git repo
#########################


#!/bin/bash

dom0_usr=user
dom0_directory=unikernel-minf
dom0_source=/home/$dom0_usr/$dom0_directory/

dest_vm_name=work
dest_vm_usr=user
dest_vm_directory=unikernel-minf
dest_vm_directory_full=/home/$dest_vm_usr/$dest_vm_directory/


cd $dom0_source

# SIMPLE SYNC
#for f in *; do
#	cat $dom0_source$f | qvm-run --pass-io $dest_vm_name 'cat > '"$dest_vm_directory$f"''
#done


# Create a Zipfile to be shared
zipfile=send.zip
zip -r $zipfile .

# Sending Zipfile to destination VM
cat $zipfile | qvm-run --pass-io $dest_vm_name 'cat > '"$dest_vm_directory_full$zipfile"''

# Running commands in the destination VM to unzip and clean the folder
qvm-run --pass-io $dest_vm_name "cd $dest_vm_directory_full; unzip $zipfile; rm $zipfile"

# Removing the Zipfile
rm -r $zipfile

echo "DONE"

