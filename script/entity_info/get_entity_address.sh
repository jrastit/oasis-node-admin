#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

ENTITY_ID=`$SCRIPT_ENTITY_INFO_DIR/get_entity_id.sh`
# $SCRIPT_DIR/oasis_local.sh stake pubkey2address --public_key $ENTITY_ID
$SCRIPT_DIR/cli_local.sh account from-public-key $ENTITY_ID

sleep 1
