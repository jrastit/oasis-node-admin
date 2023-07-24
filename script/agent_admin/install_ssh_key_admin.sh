#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo Install SSH Key #$@

#log_cmd $REMOTE_CMD_AMIN grep $@ .ssh/authorized_keys
#echo $?

KEY_FOUND=`$REMOTE_CMD_ADMIN grep $@ ~/.ssh/authorized_keys`

#echo $KEY_FOUND

if [ -z "${KEY_FOUND}" ] 
then
	echo install new key
	$REMOTE_CMD_ADMIN "echo $@ >> ~/.ssh/authorized_keys"
else
	echo key already present
fi

