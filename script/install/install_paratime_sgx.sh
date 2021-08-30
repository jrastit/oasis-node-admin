#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

cd $LOCAL_DIR
mkdir -p paratime/$CUSTOM_PARATIME_RUNTIME_VERSION
cd paratime/$CUSTOM_PARATIME_RUNTIME_VERSION
wget -O cipher-paratime.sgxs $CUSTOM_PARATIME_RUNTIME_SGSX  
wget -O cipher-paratime.sig $CUSTOM_PARATIME_RUNTIME_SIG  

rsync -rv $LOCAL_DIR/paratime/$CUSTOM_PARATIME_RUNTIME_VERSION $NETWORK_HOST:$NETWORK_RUNTIME_PATH
