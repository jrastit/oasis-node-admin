#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo "Register node ip:port" 
read NODE_IP_PORT


mkdir -p $LOCAL_NODE_DIR

cd $LOCAL_NODE_DIR

$LOCAL_BIN registry node init \
	--node.entity_id `$SCRIPT_DIR/account_info/get_entity_id.sh` \
	--node.consensus_address $NODE_IP_PORT \
	--node.role validator \

