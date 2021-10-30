#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

wget -O $GENESIS_JSON $OASIS_GENESIS_URL

rsync -rv $GENESIS_JSON $OASIS_NODE_SSH:$OASIS_NODE_GENESIS

