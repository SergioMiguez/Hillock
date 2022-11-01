#!/bin/bash

D=minf
SOURCE=/home/$D/$D/
DEST_VM=work
DESTINATION=/home/user/unikernel-$D/


cd $SOURCE

# SIMPLE SYNC
#for f in *; do
#	cat $SOURCE$f | qvm-run --pass-io $DEST_VM 'cat > '"$DESTINATION$f"''
#done


# Create a Zipfile
zipfile=send.zip
zip -r $zipfile .

# Sending Zipfile to destination VM
cat $zipfile | qvm-run --pass-io $DEST_VM 'cat > '"$DESTINATION$zipfile"''

# Running commands in the destination VM to unzip and clean the folder
qvm-run --pass-io $DEST_VM "cd $DESTINATION; unzip $zipfile; rm $zipfile"

# Removing the Zipfile
rm -r $zipfile

echo "DONE"

