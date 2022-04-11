#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo "install genesis $OASIS_GENESIS_URL"
$REMOTE_CMD wget --quiet -O $OASIS_NODE_GENESIS  $OASIS_GENESIS_URL

