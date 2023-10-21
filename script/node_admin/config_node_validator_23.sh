#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$REMOTE_CMD "cat > $OASIS_NODE_DIR/node/etc/config.yml <<- EOF
mode: validator
common:
    data_dir: $OASIS_NODE_DIR/node/data
    log:
        file: $OASIS_NODE_LOG_FILE
        format: JSON
        level:
            cometbft: info
            cometbft/context: error
            default: info
consensus:
    external_address: tcp://$OASIS_NODE_ADDR:$OASIS_NODE_PORT
    listen_address: tcp://$OASIS_NODE_LISTEN_ADDR:$OASIS_NODE_PORT
    validator: true

genesis:
  file: $OASIS_NODE_GENESIS

p2p:
    port: $PARATIME_WORKER_P2P_PORT
    registration:
        addresses:
            - \"$OASIS_NODE_ADDR:$PARATIME_WORKER_P2P_PORT\"
    seeds:
        - \"$OASIS_SEED_NODE\"
registration:
    entity: $OASIS_NODE_DIR/node/entity/entity.json


EOF"


