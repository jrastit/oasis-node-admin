#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

cd $LOCAL_DIR
mkdir -p oasis-core
cd oasis-core
if [ ! -d "$OASIS_CORE_DIR" ]; then
	wget -O $OASIS_CORE_TAR  $OASIS_CORE_URL
	tar -xf $OASIS_CORE_TAR
	rm -f $OASIS_CORE_TAR
else
	echo "Local dir $OASIS_CORE_DIR already exist"
fi

rsync -rv $LOCAL_DIR/oasis-core/$OASIS_CORE_DIR $NETWORK_HOST:$NETWORK_BIN_PATH


