#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

if [[ -n "$CUSTOM_OASIS_NODE_ADDR" ]]
then
	OASIS_NODE_ADDR=$CUSTOM_OASIS_NODE_ADDR
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
		--node.entity_id `$SCRIPT_DIR/account_info/get_entity_id.sh` 
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

  storage:
    enabled: true
  
  compute:
    enabled: true
  
  client:
    port: 30001
    addresses:
      - \"$OASIS_NODE_ADDR:$CUSTOM_PARATIME_WORKER_CLIENT_PORT\"
  
  p2p:
    enabled: true
    port: 30002
    addresses:
      - \"$OASIS_NODE_ADDR:$CUSTOM_PARATIME_WORKER_P2P_PORT\"

consensus:
  tendermint:
    core:
      listen_address: tcp://$OASIS_NODE_LISTEN_ADDR:$OASIS_NODE_PORT
      external_address: tcp://$OASIS_NODE_ADDR:$OASIS_NODE_PORT
    p2p:
      seed:
        - \"$OASIS_SEED_NODE\"

runtime:
  supported:
    - \"$CUSTOM_PARATIME_RUNTIME_IDENTIFIER\"
  paths:
    \"$CUSTOM_PARATIME_RUNTIME_IDENTIFIER\": $NETWORK_RUNTIME_PATH/$CUSTOM_PARATIME_RUNTIME_VERSION/cipher-paratime.sgxs 
  sgx:
    loader: $NETWORK_BIN_PATH/$OASIS_CORE_DIR/oasis-core-runtime-loader
    signatures:
      \"$CUSTOM_PARATIME_RUNTIME_IDENTIFIER\": $NETWORK_RUNTIME_PATH/$CUSTOM_PARATIME_RUNTIME_VERSION/cipher-paratime.sig


  
EOF"


