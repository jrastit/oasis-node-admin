#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

CMD="cat > $OASIS_NODE_DIR/node/etc/config.yml <<- EOF
mode: client
common:
    data_dir: $OASIS_NODE_DIR/node/data
    log:
        file: $OASIS_NODE_LOG_FILE
        format: JSON
        level:
            cometbft: info
            cometbft/context: error
            default: $LOG_LEVEL 

genesis:
  file: $OASIS_NODE_GENESIS

p2p:
    seeds:"
all=($OASIS_SEED_NODE)
for SEED_NODE in "${all[@]}"; do
  CMD="$CMD
        - \"$SEED_NODE\""  
done

CMD="$CMD


EOF"


echo -e "$CMD"
$REMOTE_CMD "$CMD"


