#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

rsync -rv $LOCAL_DIR/cli $OASIS_NODE_SSH:$OASIS_NODE_DIR
echo $OASIS_NODE_CLI network set-rpc $OASIS_NODE_NETWORK $OASIS_NODE_SOCK
$OASIS_NODE_CLI network set-rpc $OASIS_NODE_NETWORK $OASIS_NODE_SOCK
