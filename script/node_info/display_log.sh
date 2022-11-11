#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $OASIS_NODE_LOG_FILE
$REMOTE_CMD "ls -l $OASIS_NODE_LOG_FILE"
$REMOTE_CMD "cat $OASIS_NODE_LOG_FILE"
