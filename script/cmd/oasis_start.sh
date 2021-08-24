#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $NETWORK_BIN --config $NETWORK_CONFIG 
$NETWORK_BIN --config $NETWORK_CONFIG

