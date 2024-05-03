#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$SCRIPT_DIR/cli_local.sh wallet import-file $OASIS_NODE_ENTITY $ENTITY_DIR/entity.pem