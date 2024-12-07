#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

REMOTE_CONFIG_DIR=$OASIS_AGENT_DIR/oasis-node-admin/config
LOCAL_CONFIG_DIR=$SCRIPT_DIR/../config


for NETWORK_DIR in $LOCAL_CONFIG_DIR/network/*; do
	if [ -d $NETWORK_DIR ]; then
		NETWORK_DIR_NAME=`basename $NETWORK_DIR`
		NETWORK_DIR_REMOTE=$REMOTE_CONFIG_DIR/network/$NETWORK_DIR_NAME
		log_cmd $REMOTE_SYNC $OASIS_NODE_SSH:$NETWORK_DIR_REMOTE $NETWORK_DIR/network_config.sh
		for TYPE_DIR in $NETWORK_DIR/*; do
			if [ -d $TYPE_DIR ]; then
				TYPE_DIR_NAME=`basename $TYPE_DIR`
				TYPE_DIR_REMOTE=$REMOTE_CONFIG_DIR/network/$NETWORK_DIR_NAME/$TYPE_DIR_NAME
				log_cmd $REMOTE_SYNC $OASIS_NODE_SSH:$TYPE_DIR_REMOTE $TYPE_DIR/type_config.sh
			fi
		done
	fi
done

for NODE_DIR in $LOCAL_CONFIG_DIR/node/*; do	
	if [ -d $NODE_DIR ]; then
		NODE_DIR_NAME=`basename $NODE_DIR`
		NODE_DIR_REMOTE=$REMOTE_CONFIG_DIR/node/$NODE_DIR_NAME
		log_cmd $REMOTE_SYNC $OASIS_NODE_SSH:$NODE_DIR_REMOTE $NODE_DIR/node_config.sh
	fi
done





