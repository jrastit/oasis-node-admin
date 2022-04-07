#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

if [[ "$OASIS_CORE_VERSION" != "22."* ]]; then
	echo skip because core version is not 22
	exit 1
fi

echo $PARATIME_RUNTIME_ORC_LINK
echo $PARATIME_RUNTIME_REMOTE_DIR/$PARATIME_RUNTIME_ORC

$REMOTE_CMD test -d $PARATIME_RUNTIME_REMOTE_DIR
if [ $? == 1 ]; then
	echo "install paratime $PARATIME_RUNTIME_VERSION"
	$REMOTE_CMD mkdir -p $PARATIME_RUNTIME_REMOTE_DIR
	
	$REMOTE_CMD wget --quiet -O $PARATIME_RUNTIME_REMOTE_DIR/$PARATIME_RUNTIME_ORC  $PARATIME_RUNTIME_ORC_LINK
else
	echo "already install paratime $PARATIME_RUNTIME_VERSION"
fi


