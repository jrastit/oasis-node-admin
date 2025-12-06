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
            default: $LOG_LEVEL 
consensus:
    external_address: tcp://$OASIS_NODE_ADDR:$OASIS_NODE_PORT
    listen_address: tcp://$OASIS_NODE_LISTEN_ADDR:$OASIS_NODE_PORT"
if [[ "$OASIS_NODE_PRUNE_CONSENSUS_NUM_KEPT" =~ ^[0-9]+$ ]] ; then
CMD="$CMD
    prune:
        strategy: keep_n
        num_kept: $OASIS_NODE_PRUNE_CONSENSUS_NUM_KEPT"
fi
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
    port: $OASIS_P2P_PORT
    registration:
        addresses:
            - \"$OASIS_NODE_ADDR:$OASIS_P2P_PORT\"
    seeds:"
all=($OASIS_SEED_NODE)
for SEED_NODE in "${all[@]}"; do
  CMD="$CMD
        - \"$SEED_NODE\""  
done

CMD="$CMD

registration:
    entity: $OASIS_NODE_DIR/node/entity/entity.json

runtime:
  paths:"

RUNTIME_IAS=""
SGX_LOADER=""
all=($OASIS_NODE_TYPE)
for NODE_TYPE in "${all[@]}"; do
  echo "Loading paratime for $NODE_TYPE"
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
    echo "Setting IAS address to $PARATIME_RUNTIME_IAS"
    RUNTIME_IAS="$PARATIME_RUNTIME_IAS"
    SGX_LOADER="true"
  fi
  if [[ "$NODE_TYPE" == "sapphire" || "$NODE_TYPE" == "cipher" ]] && [ -z "$SGX_LOADER" ]; then
    SGX_LOADER="true"
  fi
done

if [ -n "$SGX_LOADER" ] ; then
    CMD="$CMD
  sgx_loader: $OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-core-runtime-loader
"
fi
if [ -n "$RUNTIME_IAS" ] ; then
    CMD="$CMD
ias:
  proxy_addresses:
    - \"$RUNTIME_IAS\""
fi

CMD="$CMD

EOF"
echo -e "$CMD"
$REMOTE_CMD "$CMD"

