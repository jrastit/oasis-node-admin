#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

CORE_DIR=$OASIS_NODE_DIR/oasis-core

$REMOTE_CMD mkdir -p $CORE_DIR
$REMOTE_CMD wget --quiet -O $CORE_DIR/$OASIS_CORE_TAR  $OASIS_CORE_URL
$REMOTE_CMD tar -C $CORE_DIR -xvf $CORE_DIR/$OASIS_CORE_TAR


