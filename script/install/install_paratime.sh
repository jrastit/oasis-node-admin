#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

PARATIME_DIR=$OASIS_NODE_RUNTIME_PATH/emerald/$PARATIME_RUNTIME_VERSION
$REMOTE_CMD test -d $PARATIME_DIR
if [ $? == 1 ]; then
	echo "install paratime $PARATIME_RUNTIME_VERSION"
	$REMOTE_CMD mkdir -p $PARATIME_DIR
	$REMOTE_CMD wget --quiet -O $PARATIME_DIR/emerald-paratime.orc  $PARATIME_RUNTIME_EMERALD_ORC
else
	echo "already install paratime $PARATIME_RUNTIME_VERSION"
fi


