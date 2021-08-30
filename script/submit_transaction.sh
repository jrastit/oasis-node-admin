#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo copy file $LOCAL_TX/$1 to $NETWORK_HOST
if [ -n "$NETWORK_HOST" ]; then 
	$REMOTE_CMD mkdir -p $NETWORK_TX
	$REMOTE_CP $LOCAL_TX/$1 $NETWORK_HOST:$NETWORK_TX/$1
	echo send transaction $1
	$SCRIPT_DIR/oasis.sh consensus submit_tx --transaction.file $NETWORK_TX/$1
else 
	$SCRIPT_DIR/oasis.sh consensus submit_tx --transaction.file $LOCAL_TX/$1
fi

