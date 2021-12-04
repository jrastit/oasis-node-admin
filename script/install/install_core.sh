#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

cd $LOCAL_DIR
mkdir -p oasis-core
cd oasis-core
if [ ! -d "$OASIS_CORE_DIR" ]; then
	download_file $OASIS_CORE_TAR  $OASIS_CORE_URL
	tar -xf $OASIS_CORE_TAR
	rm -f $OASIS_CORE_TAR
else
	echo "Local dir $OASIS_CORE_DIR already exist"
fi

log_cmd $REMOTE_SYNC $LOCAL_DIR/oasis-core/$OASIS_CORE_DIR $OASIS_NODE_SSH:$OASIS_NODE_BIN_PATH


