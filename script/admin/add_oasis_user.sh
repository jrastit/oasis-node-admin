#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$REMOTE_CMD_ADMIN adduser oasis --home /mnt/oasis 
$REMOTE_CMD_ADMIN ln -s /mnt/oasis /home/oasis

if [[ -n "$CUSTOM_OASIS_SSH_ID" ]]
then
	OASIS_SSH_ID=$CUSTOM_OASIS_SSH_ID
else
	echo "Register ssh id" 
	read OASIS_SSH_ID
fi

if [[ -n "$OASIS_SSH_ID" ]]
then
	$REMOTE_CMD_ADMIN "mkdir /mnt/oasis/.ssh"
	$REMOTE_CMD_ADMIN "chown oasis.oasis /mnt/oasis/.ssh"
	$REMOTE_CMD_ADMIN "echo \"$OASIS_SSH_ID\" | sudo tee /mnt/oasis/.ssh/authorized_keys"
	$REMOTE_CMD_ADMIN "chown oasis.oasis /mnt/oasis/.ssh/authorized_keys"
fi

