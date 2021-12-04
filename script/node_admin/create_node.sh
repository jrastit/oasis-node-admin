#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

if [[ -d "$LOCAL_NODE_DIR" ]]
then
  echo "$LOCAL_NODE_DIR exists on your filesystem. no new node generation"

	cd $LOCAL_NODE_DIR

else
	mkdir -p $LOCAL_NODE_DIR

	cd $LOCAL_NODE_DIR

	if [[ -n "$NODE_IS_VALIDATOR" ]]
	then
		log_cmd $LOCAL_BIN registry node init \
			--node.entity_id `$SCRIPT_ENTITY_INFO_DIR/get_entity_id.sh` \
			--node.consensus_address $OASIS_NODE_ADDR:$OASIS_NODE_PORT \
			--node.role validator
	else
		log_cmd $LOCAL_BIN registry node init \
			--node.entity_id `$SCRIPT_ENTITY_INFO_DIR/get_entity_id.sh`
	fi
fi

log_cmd $REMOTE_CMD mkdir -p $OASIS_NODE_DIR/node/{etc,data,entity}
log_cmd $REMOTE_SYNC consensus.pem consensus_pub.pem identity.pem identity_pub.pem p2p.pem p2p_pub.pem sentry_client_tls_identity.pem sentry_client_tls_identity_cert.pem $REMOTE_DIR/node/data
log_cmd $REMOTE_CMD chmod -R 600 $OASIS_NODE_DIR/node/data/*.pem
log_cmd $REMOTE_SYNC $ENTITY_DIR/entity.json $REMOTE_DIR/node/entity/entity.json
log_cmd $REMOTE_CMD chmod -R go-r,go-w,go-x $OASIS_NODE_DIR
