#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$OASIS_NODE_BIN unsafe-reset \
	--datadir=$OASIS_NODE_DIR/node/data 
	# --preserve.mkvs_database \
	# --log.level info


