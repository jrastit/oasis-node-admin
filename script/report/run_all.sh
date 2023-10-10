#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"

REPORT_CONFIG_DIR=$SCRIPT_DIR/../config

for NODE_DIR in $REPORT_CONFIG_DIR/node/*; do
	if [ -d $NODE_DIR ]; then
		OASIS_NODE_NAME=`basename $NODE_DIR`
		# echo NODE $OASIS_NODE_NAME
		$SCRIPT_DIR/$1 "${@:2}"
		echo
	fi
done


