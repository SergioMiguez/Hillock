#!/bin/bash

D=minf
SOURCE=/home/$D/$D/
DEST_VM=work
DESTINATION=/home/user/unikernel-$D/

cd 
cd $SOURCE

# SIMPLE SYNC
#for f in *; do
#	cat $SOURCE$f | qvm-run --pass-io $DEST_VM 'cat > '"$DESTINATION$f"''
#done


zipfile=send.zip
zip -r $zipfile .
cat $zipfile | qvm-run --pass-io $DEST_VM 'cat > '"$DESTINATION$zipfile"''
qvm-run --pass-io $DEST_VM "cd $DESTINATION; unzip $zipfile; rm $zipfile"
rm -r $zipfile


echo "DONE"

