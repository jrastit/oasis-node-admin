#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

#$SCRIPT_DIR/cmd/oasis_stop_wait.sh
#sleep 10
#$SCRIPT_DIR/cmd/oasis_start_screen.sh
$SSHCMD screen -S restart_$OASIS_NODE_NAME -dm "$OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-node control -a $OASIS_NODE_SOCK shutdown --wait;sleep 10;screen -S $OASIS_NODE_NAME -dm $OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-node --config $OASIS_NODE_CONFIG"
