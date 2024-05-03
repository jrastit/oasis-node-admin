#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$SCRIPT_DIR/cli_local.sh accounts show $OASIS_NODE_ENTITY --network $OASIS_NODE_NETWORK
echo concensus
$SCRIPT_DIR/cli_local.sh accounts show $OASIS_NODE_ENTITY --network $OASIS_NODE_NETWORK | grep -A 4 "CONSENSUS" | grep Available | cut -d ':' -f 2 | cut -d ' ' -f 2
echo cipher
$SCRIPT_DIR/cli_local.sh --paratime cipher accounts show $OASIS_NODE_ENTITY --network $OASIS_NODE_NETWORK | grep -A 4 "PARATIME" | grep Amount | cut -d ':' -f 2
echo emerald
$SCRIPT_DIR/cli_local.sh --paratime emerald accounts show $OASIS_NODE_ENTITY --network $OASIS_NODE_NETWORK | grep -A 4 "PARATIME" | grep Amount | cut -d ':' -f 2
echo sapphire
$SCRIPT_DIR/cli_local.sh --paratime sapphire accounts show $OASIS_NODE_ENTITY --network $OASIS_NODE_NETWORK | grep -A 4 "PARATIME" | grep Amount | cut -d ':' -f 2
# $SCRIPT_DIR/cli_local.sh accounts show $OASIS_NODE_ENTITY | grep -A 4 "PARATIME" | grep Amount | cut -d ':' -f 2 | cut -c 1- | rev | cut -c 10- | rev
