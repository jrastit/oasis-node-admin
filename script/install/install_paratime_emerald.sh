#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

cd $LOCAL_DIR
mkdir -p paratime/$PARATIME_RUNTIME_VERSION
cd paratime/$PARATIME_RUNTIME_VERSION
wget -O emerald-paratime $PARATIME_RUNTIME_EMERALD
chmod +x emerald-paratime

rsync -rv $LOCAL_DIR/paratime/$PARATIME_RUNTIME_VERSION $OASIS_NODE_SSH:$OASIS_NODE_RUNTIME_PATH
