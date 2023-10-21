#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh
. $SCRIPT_DIR/paratime_env.sh

CMD="cat > $OASIS_NODE_DIR/node/etc/config.yml <<- EOF
mode: compute
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
    listen_address: tcp://$OASIS_NODE_LISTEN_ADDR:$OASIS_NODE_PORT"
all=($OASIS_NODE_TYPE)
for NODE_TYPE in "${all[@]}"; do
  if [ $NODE_TYPE == "validator" ] ; then
  CMD="$CMD
  validator: true"
  fi
done
CMD="$CMD
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

runtime:
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
  sgx_loader: $OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-core-runtime-loader
    
ias:
  proxy_addresses:
      - \"$PARATIME_RUNTIME_IAS\""
fi

CMD="$CMD

EOF"
echo -e "$CMD"
$REMOTE_CMD "$CMD"

