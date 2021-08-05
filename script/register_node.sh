#!/bin/bash

. ./oasis_env.sh


mkdir -p $LOCAL_NODE_DIR

cd $LOCAL_NODE_DIR

$LOCAL_BIN registry node init \
	--node.entity_id `$SCRIPT_DIR/get_entity_id.sh` \
	--node.consensus_address $NETWORK_NODE_IP:$NETWORK_NODE_PORT \
	--node.role validator \

