#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo rm $OASIS_NODE_LOG_FILE
$REMOTE_CMD "rm $OASIS_NODE_LOG_FILE"
