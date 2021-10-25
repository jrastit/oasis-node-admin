#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $OASIS_NODE_BIN --config $OASIS_NODE_CONFIG 
$OASIS_NODE_BIN --config $OASIS_NODE_CONFIG

