#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"

REPORT_CONFIG_DIR=$SCRIPT_DIR/../config

for NODE_DIR in $REPORT_CONFIG_DIR/node/*; do
	if [ -d $NODE_DIR ]; then
		OASIS_NODE_NAME=`basename $NODE_DIR`
		. $SCRIPT_DIR/oasis_env.sh
		echo NODE $OASIS_NODE_NAME
		echo NETWORK $OASIS_NODE_NETWORK
		if [[ $OASIS_NODE_NETWORK == 'mainnet' ]]; then
			$SCRIPT_DIR/$1
		fi
		echo
	fi
done


