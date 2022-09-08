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
  file: $OASIS_NODE_LOG_FILE

genesis:
  file: $OASIS_NODE_GENESIS

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


