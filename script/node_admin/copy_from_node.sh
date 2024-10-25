#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo source node data directory : 
read SOURCE_NODE_DIR

$REMOTE_CMD rm -rf $OASIS_NODE_DIR/node/data/consensus/state $OASIS_NODE_DIR/node/data/consensus/data
$REMOTE_CMD rsync -av --stats --progress $SOURCE_NODE_DIR/node/data/consensus/data $SOURCE_NODE_DIR/node/data/consensus/state $OASIS_NODE_DIR/node/data/consensus
$REMOTE_CMD chmod go-xrw -R $OASIS_NODE_DIR/node/data/consensus

