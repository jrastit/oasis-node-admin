#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

if [ ! -d "$PARATIME_RUNTIME_DIR" ]; then
	mkdir -p $PARATIME_RUNTIME_DIR
	download_file $PARATIME_RUNTIME_DIR/cipher-paratime.sgxs $PARATIME_RUNTIME_SGSX
	download_file $PARATIME_RUNTIME_DIR/cipher-paratime.sig $PARATIME_RUNTIME_SIG
	chmod +x cipher-paratime.sgxs
	chmod +x cipher-paratime.sig
else
	echo Paratime already dowloaded :  $PARATIME_RUNTIME_DIR
fi

$REMOTE_CMD mkdir -p $OASIS_NODE_RUNTIME_PATH/cipher
$REMOTE_SYNC $PARATIME_RUNTIME_DIR $OASIS_NODE_SSH:$OASIS_NODE_RUNTIME_PATH/cipher
