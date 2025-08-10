#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$SCRIPT_DIR/cli_local.sh account entity register $ENTITY_DIR/entity.json --account $OASIS_NODE_ENTITY --network $OASIS_NODE_NETWORK
