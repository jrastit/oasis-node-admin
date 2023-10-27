#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$REMOTE_CMD "df -h $OASIS_NODE_DIR"
$REMOTE_CMD "lsb_release -a"
$REMOTE_CMD "ps aux | grep oasis-node | grep config.yml"
