#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$REMOTE_CMD_ADMIN adduser oasis --home /home/oasis 
#$REMOTE_CMD_ADMIN ln -s /home/oasis /home

if [[ -n "$OASIS_NODE_SSH_ID" ]]
then
	OASIS_NODE_SSH_ID="$OASIS_NODE_SSH_ID"
else
	echo "Register ssh id" 
	read OASIS_NODE_SSH_ID
fi

if [[ -n "$OASIS_NODE_SSH_ID" ]]
then
	$REMOTE_CMD_ADMIN "mkdir /home/oasis/.ssh"
	$REMOTE_CMD_ADMIN "chown oasis.oasis /home/oasis/.ssh"
	$REMOTE_CMD_ADMIN "echo \"$OASIS_NODE_SSH_ID\" | sudo tee /home/oasis/.ssh/authorized_keys"
	$REMOTE_CMD_ADMIN "chown oasis.oasis /home/oasis/.ssh/authorized_keys"
fi

