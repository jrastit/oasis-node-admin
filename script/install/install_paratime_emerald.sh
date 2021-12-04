#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

if [ ! -d "$PARATIME_RUNTIME_DIR" ]; then
	mkdir -p $PARATIME_RUNTIME_DIR
	download_file $PARATIME_RUNTIME_DIR/emerald-paratime $PARATIME_RUNTIME_EMERALD
	chmod +x emerald-paratime
fi

$REMOTE_CMD mkdir -p $OASIS_NODE_RUNTIME_PATH/emerald
$REMOTE_SYNC $PARATIME_RUNTIME_DIR $OASIS_NODE_SSH:$OASIS_NODE_RUNTIME_PATH/emerald
