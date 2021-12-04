#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$REMOTE_CMD "cat > $OASIS_NODE_DIR/node/etc/config.yml <<- EOF
datadir: $OASIS_NODE_DIR/node/data
log:
  level:
    default: info
    tendermint: info
    tendermint/context: error
  format: JSON

genesis:
  file: $OASIS_NODE_GENESIS

worker:
  registration:
    entity: $OASIS_NODE_DIR/node/entity/entity.json

  storage:
    enabled: true
  
  compute:
    enabled: true
  
  client:
    port: $PARATIME_WORKER_CLIENT_PORT
    addresses:
      - \"$OASIS_NODE_ADDR:$PARATIME_WORKER_CLIENT_PORT\"
  
  p2p:
    enabled: true
    port: $PARATIME_WORKER_P2P_PORT
    addresses:
      - \"$OASIS_NODE_ADDR:$PARATIME_WORKER_P2P_PORT\"

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
    - \"$PARATIME_RUNTIME_IDENTIFIER\"
  paths:
    \"$PARATIME_RUNTIME_IDENTIFIER\": $OASIS_NODE_RUNTIME_PATH/cipher/$PARATIME_RUNTIME_VERSION/cipher-paratime.sgxs 
  sgx:
    loader: $OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-core-runtime-loader
    signatures:
      \"$PARATIME_RUNTIME_IDENTIFIER\": $OASIS_NODE_RUNTIME_PATH/cipher/$PARATIME_RUNTIME_VERSION/cipher-paratime.sig

ias:
  proxy:
    address:
      - \"$PARATIME_RUNTIME_IAS\"
  
EOF"


