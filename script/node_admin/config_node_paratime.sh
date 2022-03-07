#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

CMD="cat > $OASIS_NODE_DIR/node/etc/config.yml <<- EOF
datadir: $OASIS_NODE_DIR/node/data
log:
  level:
    default: error
    tendermint: error
    tendermint/context: error
  format: JSON

genesis:
  file: $OASIS_NODE_GENESIS

worker:
  registration:
    entity: $OASIS_NODE_DIR/node/entity/entity.json

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
  mode: compute
  paths:
    - $OASIS_NODE_RUNTIME_PATH/emerald/$PARATIME_RUNTIME_VERSION/emerald-paratime.orc" 

if [ -n "$PARATIME_RUNTIME_VERSION_OLD" ] ; then
    CMD="$CMD
    - $OASIS_NODE_RUNTIME_PATH/emerald/$PARATIME_RUNTIME_VERSION_OLD/emerald-paratime.orc" 
fi

CMD="$CMD

EOF"
echo -e "$CMD"
$REMOTE_CMD "$CMD"

