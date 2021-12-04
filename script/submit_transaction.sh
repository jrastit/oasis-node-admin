#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo copy file $LOCAL_TX/$1 to $OASIS_NODE_SSH
if [ -n "$OASIS_NODE_SSH" ]; then 
	$REMOTE_CMD mkdir -p $OASIS_NODE_TX
	$REMOTE_CP $LOCAL_TX/$1 $OASIS_NODE_SSH:$OASIS_NODE_TX/$1
	echo send transaction $1
	$SCRIPT_DIR/oasis.sh consensus submit_tx --transaction.file $OASIS_NODE_TX/$1
else 
	$SCRIPT_DIR/oasis.sh consensus submit_tx --transaction.file $LOCAL_TX/$1
fi

