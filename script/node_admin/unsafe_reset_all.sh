#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$OASIS_NODE_BIN unsafe-reset \
	--preserve.mkvs_database=false \
	--datadir=$OASIS_NODE_DIR/node/data


