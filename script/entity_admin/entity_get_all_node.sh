#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

OASIS_NODE_NETWORK_ORIGIN=$OASIS_NODE_NETWORK
OASIS_NODE_ENTITY_ORIGIN=$OASIS_NODE_ENTITY
REPORT_CONFIG_DIR=$SCRIPT_DIR/../config

for NODE_DIR in $REPORT_CONFIG_DIR/node/*; do
	if [ -d $NODE_DIR ]; then
		OASIS_NODE_NAME=`basename $NODE_DIR`
		. $SCRIPT_DIR/oasis_env.sh
		if [[ "$OASIS_NODE_NETWORK_ORIGIN" == "$OASIS_NODE_NETWORK" ]]; then
			if [[ "$OASIS_NODE_ENTITY_ORIGIN" == "$OASIS_NODE_ENTITY" ]]; then
				if [[ "$OASIS_NODE_REGISTER" == "true" ]]; then
					#echo NODE $OASIS_NODE_NAME
					#$SCRIPT_ENTITY_INFO_DIR/get_entity_id.sh
					$SCRIPT_NODE_INFO_DIR/node_id.sh
				fi
			fi
		fi

	fi
done
