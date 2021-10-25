#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

if [[ -n "$OASIS_NODE_ADDR" ]]
then
	OASIS_NODE_ADDR=$OASIS_NODE_ADDR
else
	echo "Register node ip" 
	read OASIS_NODE_ADDR	
fi


if [[ -d "$LOCAL_NODE_DIR" ]]
then
  echo "$LOCAL_NODE_DIR exists on your filesystem. no new node generation"

	cd $LOCAL_NODE_DIR

else
	mkdir -p $LOCAL_NODE_DIR

	cd $LOCAL_NODE_DIR

	$LOCAL_BIN registry node init \
		--node.entity_id `$SCRIPT_DIR/account_info/get_entity_id.sh` \
		--node.consensus_address $OASIS_NODE_ADDR:$OASIS_NODE_PORT \
		--node.role validator
fi


echo $REMOTE_CMD mkdir -p $OASIS_NODE_DIR/node/{etc,data,entity}
$REMOTE_CMD mkdir -p $OASIS_NODE_DIR/node/{etc,data,entity}
echo $REMOTE_CP consensus.pem consensus_pub.pem identity.pem identity_pub.pem p2p.pem p2p_pub.pem sentry_client_tls_identity.pem sentry_client_tls_identity_cert.pem $REMOTE_DIR/node/data
$REMOTE_CP consensus.pem consensus_pub.pem identity.pem identity_pub.pem p2p.pem p2p_pub.pem sentry_client_tls_identity.pem sentry_client_tls_identity_cert.pem $REMOTE_DIR/node/data
$REMOTE_CMD chmod -R 600 $OASIS_NODE_DIR/node/data/*.pem
$REMOTE_CP ../../entity.json $REMOTE_DIR/node/entity/entity.json
$REMOTE_CMD chmod -R go-r,go-w,go-x $OASIS_NODE_DIR

$REMOTE_CMD "cat > $OASIS_NODE_DIR/node/etc/config.yml <<- EOF
datadir: $OASIS_NODE_DIR/node/data
log:
  level:
    default: info
    tendermint: info
    tendermint/context: error
  format: JSON

genesis:
  file: $OASIS_NODE_DIR/node/etc/genesis.json

worker:
  registration:
    entity: $OASIS_NODE_DIR/node/entity/entity.json

consensus:
  validator: true
  tendermint:
    core:
      listen_address: tcp://$OASIS_NODE_LISTEN_ADDR:$OASIS_NODE_PORT
      external_address: tcp://$OASIS_NODE_ADDR:$OASIS_NODE_PORT
    p2p:
      seed:
        - \"$OASIS_SEED_NODE\"
EOF"


