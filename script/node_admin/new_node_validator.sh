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

	$LOCAL_BIN registry node init \
		--node.entity_id `$SCRIPT_DIR/account_info/get_entity_id.sh` \
		--node.consensus_address $NODE_IP_PORT \
		--node.role validator
fi

if [[ -n "$CUSTOM_NODE_ADDR" ]]
then
	NODE_IP_PORT=$CUSTOM_NODE_ADDR
else
	echo "Register node ip:port" 
	read NODE_IP_PORT	
fi

echo $REMOTE_CMD mkdir -p $NETWORK_DIR/node/{etc,data,entity}
$REMOTE_CMD mkdir -p $NETWORK_DIR/node/{etc,data,entity}
echo $REMOTE_CP consensus.pem consensus_pub.pem identity.pem identity_pub.pem p2p.pem p2p_pub.pem sentry_client_tls_identity.pem sentry_client_tls_identity_cert.pem $REMOTE_DIR/node/data
$REMOTE_CP consensus.pem consensus_pub.pem identity.pem identity_pub.pem p2p.pem p2p_pub.pem sentry_client_tls_identity.pem sentry_client_tls_identity_cert.pem $REMOTE_DIR/node/data
$REMOTE_CMD chmod -R 600 $NETWORK_DIR/node/data/*.pem
$REMOTE_CP ../../entity.json $REMOTE_DIR/node/entity/entity.json
$REMOTE_CMD chmod -R go-r,go-w,go-x $NETWORK_DIR

$REMOTE_CMD "cat > $NETWORK_DIR/node/etc/config.yml <<- EOF
datadir: $NETWORK_DIR/node/data
log:
  level:
    default: info
    tendermint: info
    tendermint/context: error
  format: JSON

genesis:
  file: $NETWORK_DIR/node/etc/genesis.json

worker:
  registration:
    entity: $NETWORK_DIR/node/entity/entity.json

consensus:
	validator: true
  tendermint:
		core:
      listen_address: tcp://$NETWORK_HOST
      external_address: tcp://$NETWORK_HOST
    p2p:
      seed:
        - \"$OASIS_SEED_NODE\"
EOF"


