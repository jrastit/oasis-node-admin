#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

log_cmd $REMOTE_CMD mkdir -p $OASIS_AGENT_DIR
log_cmd $REMOTE_CMD "cd $OASIS_AGENT_DIR ; [ -d oasis-node-admin ] && ( cd oasis-node-admin && git pull ) || echo git clone $GIT_URL"
log_cmd $REMOTE_CMD "[ -f .ssh/id_rsa.pub ] || ssh-keygen -f .ssh/id_rsa -N \"\""
KEY=`$REMOTE_CMD cat .ssh/id_rsa.pub`
echo SSH Key $KEY
$SCRIPT_DIR/report/report_all.sh "agent_admin/install_ssh_key.sh \"$KEY\""

REMOTE_CONFIG_DIR=$OASIS_AGENT_DIR/oasis-node-admin/config
LOCAL_CONFIG_DIR=$SCRIPT_DIR/../config

$REMOTE_CMD mkdir -p REMOTE_CONFIG_DIR/{entity,network,node,api}
log_cmd $REMOTE_SYNC $LOCAL_CONFIG_DIR/api/* $OASIS_NODE_SSH:$REMOTE_CONFIG_DIR/api

for NETWORK_DIR in $LOCAL_CONFIG_DIR/entity/*; do
	if [ -d $NETWORK_DIR ]; then
		NETWORK_DIR_NAME=`basename $NETWORK_DIR`
		for ENTITY_DIR in $NETWORK_DIR/*; do
			if [ -d $ENTITY_DIR ]; then
				ENTITY_DIR_NAME=`basename $ENTITY_DIR`
				ENTITY_DIR_REMOTE=$REMOTE_CONFIG_DIR/entity/$NETWORK_DIR_NAME/$ENTITY_DIR_NAME
				log_cmd $REMOTE_CMD mkdir -p $ENTITY_DIR_REMOTE
				log_cmd $REMOTE_SYNC $ENTITY_DIR/entity.json $OASIS_NODE_SSH:$ENTITY_DIR_REMOTE
			fi
		done
	fi
done

for NETWORK_DIR in $LOCAL_CONFIG_DIR/network/*; do
	if [ -d $NETWORK_DIR ]; then
		NETWORK_DIR_NAME=`basename $NETWORK_DIR`
		NETWORK_DIR_REMOTE=$REMOTE_CONFIG_DIR/network/$NETWORK_DIR_NAME
		log_cmd $REMOTE_CMD mkdir -p $NETWORK_DIR_REMOTE
		log_cmd $REMOTE_SYNC $NETWORK_DIR/network_config.sh $OASIS_NODE_SSH:$NETWORK_DIR_REMOTE
		for TYPE_DIR in $NETWORK_DIR/*; do
			if [ -d $TYPE_DIR ]; then
				TYPE_DIR_NAME=`basename $TYPE_DIR`
				TYPE_DIR_REMOTE=$REMOTE_CONFIG_DIR/network/$NETWORK_DIR_NAME/$TYPE_DIR_NAME
				log_cmd $REMOTE_CMD mkdir -p $TYPE_DIR_REMOTE
				log_cmd $REMOTE_SYNC $TYPE_DIR/type_config.sh $OASIS_NODE_SSH:$TYPE_DIR_REMOTE
			fi
		done
	fi
done

for NODE_DIR in $LOCAL_CONFIG_DIR/node/*; do	
	if [ -d $NODE_DIR ]; then
		NODE_DIR_NAME=`basename $NODE_DIR`
		NODE_DIR_REMOTE=$REMOTE_CONFIG_DIR/node/$NODE_DIR_NAME
		log_cmd $REMOTE_CMD mkdir -p $NODE_DIR_REMOTE
		log_cmd $REMOTE_SYNC $NODE_DIR/node_config.sh $OASIS_NODE_SSH:$NODE_DIR_REMOTE
	fi
done





