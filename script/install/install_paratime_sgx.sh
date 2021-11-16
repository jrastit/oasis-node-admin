#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

cd $LOCAL_DIR
mkdir -p paratime/cipher/$PARATIME_RUNTIME_VERSION
cd paratime/cipher/$PARATIME_RUNTIME_VERSION
wget -O cipher-paratime.sgxs $PARATIME_RUNTIME_SGSX  
wget -O cipher-paratime.sig $PARATIME_RUNTIME_SIG  

rsync -rv $LOCAL_DIR/paratime/cipher/$PARATIME_RUNTIME_VERSION $OASIS_NODE_SSH:$OASIS_NODE_RUNTIME_PATH
