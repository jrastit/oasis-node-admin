#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

log_cmd $REMOTE_SYNC $LOCAL_DIR/cli $OASIS_NODE_SSH:$OASIS_NODE_DIR
log_cmd mkdir -p ~/.config/oasis/
log_cmd $REMOTE_SYNC ~/.config/oasis $OASIS_NODE_SSH:~/.config/oasis
log_cmd $OASIS_NODE_CLI network set-rpc $OASIS_NODE_NETWORK $OASIS_NODE_SOCK
log_cmd $OASIS_NODE_CLI paratime set-default $OASIS_NODE_NETWORK $OASIS_NODE_PARATIME
log_cmd $OASIS_NODE_CLI network set-default $OASIS_NODE_NETWORK

