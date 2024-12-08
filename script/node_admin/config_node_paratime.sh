#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh
. $SCRIPT_DIR/paratime_env.sh

CMD="cat > $OASIS_NODE_DIR/node/etc/config.yml <<- EOF
datadir: $OASIS_NODE_DIR/node/data
log:
  level:
    default: error
    tendermint: error
    tendermint/context: error
  format: JSON
  file: $OASIS_NODE_LOG_FILE

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

consensus:"
all=($OASIS_NODE_TYPE)
for NODE_TYPE in "${all[@]}"; do
  if [ $NODE_TYPE == "validator" ] ; then
  CMD="$CMD
  validator: true"
  fi
  
done

CMD="$CMD
  tendermint:
    core:
      listen_address: tcp://$OASIS_NODE_LISTEN_ADDR:$OASIS_NODE_PORT
      external_address: tcp://$OASIS_NODE_ADDR:$OASIS_NODE_PORT
    p2p:
      seed:"
all=($OASIS_SEED_NODE)
for SEED_NODE in "${all[@]}"; do
  CMD="$CMD
        - \"$SEED_NODE\""  
done

CMD="$CMD

runtime:
  mode: compute
  paths:"

RUNTIME_IAS=""
all=($OASIS_NODE_TYPE)
for NODE_TYPE in "${all[@]}"; do
  load_paratime $NODE_TYPE
  if [ -n "$PARATIME_RUNTIME_REMOTE_DIR" ] ; then
  CMD="$CMD
  - $PARATIME_RUNTIME_REMOTE_DIR/$PARATIME_RUNTIME_ORC" 
  fi
  if [ -n "$PARATIME_RUNTIME_OLD_REMOTE_DIR" ] ; then
  CMD="$CMD
  - $PARATIME_RUNTIME_OLD_REMOTE_DIR/$PARATIME_RUNTIME_ORC" 
  fi
  if [ -n "$PARATIME_RUNTIME_IAS" ] && [ -z "$RUNTIME_IAS" ] ; then
    RUNTIME_IAS="$PARATIME_RUNTIME_IAS"
  fi
done

if [ -n "$RUNTIME_IAS" ] ; then
    CMD="$CMD

  sgx:
    loader: $OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-core-runtime-loader
    
ias:
  proxy:
    address:
      - \"$PARATIME_RUNTIME_IAS\""
fi

CMD="$CMD

EOF"
echo -e "$CMD"
$REMOTE_CMD "$CMD"

