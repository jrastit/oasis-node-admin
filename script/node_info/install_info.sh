#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh


echo $OASIS_NODE_BIN_PATH
#$REMOTE_CMD "ls -lrt $OASIS_NODE_BIN_PATH"

echo $OASIS_NODE_RUNTIME_PATH
#$REMOTE_CMD "ls -lrt $OASIS_NODE_RUNTIME_PATH"

echo $LOCAL_DIR/cli
#$REMOTE_CMD "ls -lrt $LOCAL_DIR/cli"

echo $OASIS_AGENT_DIR
$REMOTE_CMD "ls -lrt $OASIS_AGENT_DIR 2>/dev/null"
echo $?

echo $OASIS_NODE_DIR/cron
$REMOTE_CMD "ls -lrt $OASIS_NODE_DIR/cron 2>/dev/null"
echo $?
